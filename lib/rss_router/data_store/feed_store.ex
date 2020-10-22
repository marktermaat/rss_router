defmodule RssRouter.FeedStore do
  @spec get_feeds() :: [String.t()]
  def get_feeds() do
    {:ok, table} = get_or_create_table!()

    try do
      get_feeds(table)
    after
      close(table)
    end
  end

  @spec insert_feed(Strint.t()) :: :ok
  def insert_feed(feed) do
    {:ok, table} = get_or_create_table!()

    try do
      feeds = get_feeds(table) ++ [feed]
      :ok = :dets.insert(table, {:feeds, feeds})
    after
      close(table)
    end
  end

  @spec get_feed_latest_timestamp(String.t()) :: DateTime | :none
  def get_feed_latest_timestamp(feed_title) do
    {:ok, table} = get_or_create_table!()

    try do
      result = :dets.lookup(table, feed_title)

      case result do
        [{^feed_title, timestamp}] -> timestamp
        [] -> :none
      end
    after
      close(table)
    end
  end

  @spec set_feed_latest_timestamp(String.t(), DateTime) :: :ok
  def set_feed_latest_timestamp(feed_title, timestamp) do
    {:ok, table} = get_or_create_table!()

    try do
      :ok = :dets.insert(table, {feed_title, timestamp})
    after
      close(table)
    end
  end

  def delete_latest_timestamp(feed_title) do
    {:ok, table} = get_or_create_table!()

    try do
      :ok = :dets.delete(table, feed_title)
    after
      close(table)
    end
  end

  defp get_feeds(table) do
    result = :dets.lookup(table, :feeds)

    case result do
      [feeds: feeds] -> feeds
      [] -> []
    end
  end

  defp get_or_create_table!() do
    File.mkdir_p(RssRouter.Config.data_path())
    :dets.open_file(dets_file(), access: :read_write, type: :set)
  end

  defp dets_file() do
    to_charlist(data_path()) ++ '/feed_data'
  end

  defp close(table) do
    :dets.close(table)
  end
end
