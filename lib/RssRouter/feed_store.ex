defmodule RssRouter.FeedStore do
  @dets_directory Application.fetch_env!(:rss_router, :data_path)

  def get_feeds() do
    {:ok, table} = get_or_create_table!()

    try do
      get_feeds(table)
    after
      close(table)
    end
  end

  def insert_feed(feed) do
    {:ok, table} = get_or_create_table!()

    try do
      feeds = get_feeds(table) ++ [feed]
      :ok = :dets.insert(table, {:feeds, feeds})
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
    File.mkdir_p(@dets_directory)
    :dets.open_file(dets_file(), access: :read_write, type: :set)
  end

  defp dets_file() do
    to_charlist(@dets_directory) ++ '/feed_data'
  end

  defp close(table) do
    :dets.close(table)
  end
end
