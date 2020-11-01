defmodule RssRouter.FeedData.FeedStore do
  @data_path Application.fetch_env!(:rss_router, :data_path)

  def get_feeds() do
    query(fn table ->
      get_feeds(table)
    end)
  end

  def insert_feed(feed) do
    query(fn table ->
      :dets.insert_new(table, {feed, :none})
      :ok
    end)
  end

  def insert_feed(feed, timestamp) do
    query(fn table ->
      :ok = :dets.insert(table, {feed, timestamp})
    end)
  end

  def get_feed_latest_timestamp(feed) do
    query(fn table ->
      result = :dets.lookup(table, feed)

      case result do
        [{^feed, timestamp}] -> timestamp
        [] -> :none
      end
    end)
  end

  def delete_feed(feed) do
    query(fn table ->
      :ok = :dets.delete(table, feed)
    end)
  end

  def get_all_latest_entries() do
    query(fn table ->
      :dets.foldl(fn x, res -> res ++ [x] end, [], table)
    end)
  end

  def table_name do
    "feed_db"
  end

  defp query(fun) do
    File.mkdir_p(@data_path)
    dets_file = @data_path <> "/" <> table_name()
    {:ok, table} = :dets.open_file(to_charlist(dets_file), access: :read_write, type: :set)

    try do
      fun.(table)
    after
      :dets.close(table)
    end
  end

  defp get_feeds(table) do
    :dets.foldl(fn {feed, _}, res -> res ++ [feed] end, [], table)
  end
end
