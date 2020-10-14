defmodule RssRouter.FeedStore do
  @dets_directory Application.fetch_env!(:rss_router, :data_path)

  def get_feeds() do
    {:ok, table} = get_or_create_table!()
    result = :dets.lookup(table, :feeds)
    :ok = :dets.close(table)

    case result do
      [feeds: feeds] -> feeds
      [] -> []
    end
  end

  def insert_feed(feed) do
    {:ok, table} = get_or_create_table!()
    [feeds: feeds] = :dets.lookup(table, :feeds)
    new_feeds = feeds ++ [feed]
    :ok = :dets.insert(table, {:feeds, new_feeds})
    :ok = :dets.close(table)
  end

  defp get_or_create_table!() do
    File.mkdir_p(@dets_directory)
    :dets.open_file(dets_file(), access: :read_write, type: :set)
  end

  defp dets_file() do
    to_charlist(@dets_directory) ++ '/feed_data'
  end
end
