defmodule RssRouter.FeedStore do
  @spec get_feeds() :: [String.t()]
  def get_feeds() do
    query(fn table ->
      get_feeds(table)
    end)
  end

  @spec insert_feed(String.t()) :: :ok
  def insert_feed(feed) do
    query(fn table ->
      :ok = :dets.insert(table, {feed, :none})
    end)
  end

  @spec insert_feed(String.t(), DateTime) :: :ok
  def insert_feed(feed, timestamp) do
    query(fn table ->
      :ok = :dets.insert(table, {feed, timestamp})
    end)
  end

  @spec get_feed_latest_timestamp(String.t()) :: DateTime | :none
  def get_feed_latest_timestamp(feed) do
    query(fn table ->
      result = :dets.lookup(table, feed)

      case result do
        [{^feed, timestamp}] -> timestamp
        [] -> :none
      end
    end)
  end

  def delete_latest_timestamp(feed) do
    query(fn table ->
      :ok = :dets.delete(table, feed)
    end)
  end

  @spec get_all_latest_entries() :: [{String.t(), DateTime}]
  def get_all_latest_entries() do
    query(fn table ->
      :dets.foldl(fn x, res -> res ++ [x] end, [], table)
    end)
  end

  def table_name do
    "feed_db"
  end

  defp query(fun) do
    File.mkdir_p(RssRouter.Config.data_path())
    dets_file = RssRouter.Config.data_path() <> "/" <> table_name
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
