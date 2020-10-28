defmodule RssRouter.Router.FeedProcessor do
  def process_feed(rule) do
    feed = RssRouter.Router.FeedReader.read_feed(rule.uri)

    process_new_feeds(feed, rule)

    update_latest_timestamp(feed, rule)
  end

  defp process_new_feeds(feed, rule) do
    latest_timestamp = RssRouter.FeedStore.get_feed_latest_timestamp(rule.uri)

    feed.entries
    |> Enum.filter(fn e -> feed_entry_is_new(latest_timestamp, e.updated) end)
    |> Enum.each(fn entry -> process_feed_entry(rule, entry) end)
  end

  defp update_latest_timestamp(feed, rule) do
    case Enum.fetch(feed.entries, -1) do
      {:ok, last_entry} ->
        RssRouter.FeedStore.insert_feed(rule.uri, last_entry.updated)
    end
  end

  defp feed_entry_is_new(:none, _feed_entry_timestamp) do
    true
  end

  defp feed_entry_is_new(latest_timestamp, feed_entry_timestamp) do
    DateTime.compare(feed_entry_timestamp, latest_timestamp) == :gt
  end

  defp process_feed_entry(rule, entry) do
    IO.puts("#{entry.title} / #{entry.url}")
    rule.publisher.publish(entry.title, entry.url)
  end
end
