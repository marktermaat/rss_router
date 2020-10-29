defmodule RssRouter.Web.HomeController do
  use RssRouter.Web, :controller

  def index(conn, _params) do
    feeds = RssRouter.FeedStore.get_feeds()
    latest_entries = RssRouter.FeedStore.get_all_latest_entries()
    render(conn, "index.html", feeds: feeds, latest_entries: latest_entries)
  end

  def add_feed(conn, params) do
    {:ok, feed} = Map.fetch(params, "feed")
    RssRouter.FeedStore.insert_feed(feed)
    RssRouter.Router.Supervisor.start_feed_service(feed)
    redirect(conn, to: "/")
  end

  def delete(conn, params) do
    {:ok, feed_encoded} = Map.fetch(params, "feed")
    {:ok, feed} = Base.decode16(feed_encoded)
    RssRouter.FeedStore.delete_feed(feed)
    RssRouter.Router.Supervisor.stop_feed_service(feed)
    redirect(conn, to: "/")
  end
end
