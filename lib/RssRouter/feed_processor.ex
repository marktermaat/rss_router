defmodule RssRouter.FeedProcessor do
  def process_feed(uri) do
    try do
      {:ok, feed} = Feedex.fetch_and_parse(uri)
      latest_timestamp = RssRouter.FeedStore.get_feed_latest_timestamp(feed.title)

      feed.entries
      |> Enum.filter(fn e -> feed_entity_is_new(latest_timestamp, e.updated) end)
      |> Enum.each(fn e -> process_feed_entity(e) end)

      case Enum.fetch(feed.entries, -1) do
        {:ok, last_entity} ->
          RssRouter.FeedStore.set_feed_latest_timestamp(feed.title, last_entity.updated)
      end
    rescue
      e in RuntimeError -> IO.puts("An error occurred: " <> e.message)
    end
  end

  defp feed_entity_is_new(:none, _feed_entity_timestamp) do
    true
  end

  defp feed_entity_is_new(latest_timestamp, feed_entity_timestamp) do
    DateTime.compare(feed_entity_timestamp, latest_timestamp) == :gt
  end

  defp process_feed_entity(entity) do
    IO.puts(entity.title)
  end
end
