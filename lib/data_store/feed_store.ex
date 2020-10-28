defmodule RssRouter.FeedStore do
  @spec get_feeds() :: [String.t()]
  def get_feeds() do
    query(fn table ->
      get_feeds(table)
    end)
  end

  @spec insert_feed(Strint.t()) :: :ok
  def insert_feed(feed) do
    query(fn table ->
      feeds = Enum.uniq(get_feeds(table) ++ [feed])
      :ok = :dets.insert(table, {:feeds, feeds})
    end)
  end

  @spec get_feed_latest_timestamp(String.t()) :: DateTime | :none
  def get_feed_latest_timestamp(feed_title) do
    query(fn table ->
      result = :dets.lookup(table, feed_title)

      case result do
        [{^feed_title, timestamp}] -> timestamp
        [] -> :none
      end
    end)
  end

  @spec set_feed_latest_timestamp(String.t(), DateTime) :: :ok
  def set_feed_latest_timestamp(feed_title, timestamp) do
    query(fn table ->
      :ok = :dets.insert(table, {feed_title, timestamp})
    end)
  end

  def delete_latest_timestamp(feed_title) do
    query(fn table ->
      :ok = :dets.delete(table, feed_title)
    end)
  end

  @spec get_all_latest_entries() :: [{String.t(), DateTime}]
  def get_all_latest_entries() do
    query(fn table ->
      :dets.foldl(fn x, res -> res ++ [x] end, [], table)
      |> Enum.reject(fn {x, _} -> x == :feeds end)
    end)
  end

  defp query(fun) do
    File.mkdir_p(RssRouter.Config.data_path())
    dets_file = to_charlist(RssRouter.Config.data_path()) ++ '/feed_data'
    {:ok, table} = :dets.open_file(dets_file, access: :read_write, type: :set)

    try do
      fun.(table)
    after
      :dets.close(table)
    end
  end

  defp get_feeds(table) do
    result = :dets.lookup(table, :feeds)

    case result do
      [feeds: feeds] -> feeds
      [] -> []
    end
  end
end
