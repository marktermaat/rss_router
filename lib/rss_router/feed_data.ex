defmodule RssRouter.FeedData do
  @spec get_feeds() :: [String.t()]
  def get_feeds() do
    RssRouter.FeedData.FeedStore.get_feeds()
  end

  @spec insert_feed(String.t()) :: :ok
  def insert_feed(feed) do
    RssRouter.FeedData.FeedStore.insert_feed(feed)
  end

  @spec insert_feed(String.t(), DateTime) :: :ok
  def insert_feed(feed, timestamp) do
    RssRouter.FeedData.FeedStore.insert_feed(feed, timestamp)
  end

  @spec get_feed_latest_timestamp(String.t()) :: DateTime | :none
  def get_feed_latest_timestamp(feed) do
    RssRouter.FeedData.FeedStore.get_feed_latest_timestamp(feed)
  end

  @spec delete_feed(String.t()) :: :ok
  def delete_feed(feed) do
    RssRouter.FeedData.FeedStore.delete_feed(feed)
  end

  @spec get_all_latest_entries() :: [{String.t(), DateTime}]
  def get_all_latest_entries() do
    RssRouter.FeedData.FeedStore.get_all_latest_entries()
  end
end
