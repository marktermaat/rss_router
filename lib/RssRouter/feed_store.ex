defmodule RssRouter.FeedStore do
  @dets_file './feed_data'

  def get_feeds() do
    {:ok, table} = get_or_create_table!()
    [feeds: feeds] = :dets.lookup(table, :feeds)
    :ok = :dets.close(table)
    feeds
  end

  def insert_feed(feed) do
    {:ok, table} = get_or_create_table!()
    [feeds: feeds] = :dets.lookup(table, :feeds)
    new_feeds = feeds ++ [feed]
    :ok = :dets.insert(table, {:feeds, new_feeds})
    :ok = :dets.close(table)
  end

  defp get_or_create_table!() do
    :dets.open_file(@dets_file)
  end
end
