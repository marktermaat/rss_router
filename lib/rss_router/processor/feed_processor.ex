defmodule RssRouter.FeedProcessor do
  def process_feed(rule) do
    feed = get_feed(rule.uri)

    get_new_feed_entries(feed)
    |> Enum.each(&process_feed_entry/1)

    update_latest_timestamp(feed)
  end

  defp get_feed(uri) do
    {:ok, feed} = Feedex.fetch_and_parse(uri)
    feed
  end

  defp get_new_feed_entries(feed) do
    latest_timestamp = RssRouter.FeedStore.get_feed_latest_timestamp(feed.title)

    feed.entries
    |> Enum.filter(fn e -> feed_entry_is_new(latest_timestamp, e.updated) end)
  end

  defp update_latest_timestamp(feed) do
    case Enum.fetch(feed.entries, -1) do
      {:ok, last_entry} ->
        RssRouter.FeedStore.set_feed_latest_timestamp(feed.title, last_entry.updated)
    end
  end

  defp feed_entry_is_new(:none, _feed_entry_timestamp) do
    true
  end

  defp feed_entry_is_new(latest_timestamp, feed_entry_timestamp) do
    DateTime.compare(feed_entry_timestamp, latest_timestamp) == :gt
  end

  defp process_feed_entry(entry) do
    IO.puts(entry.title)
  end
end
