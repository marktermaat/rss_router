defmodule RssRouter.Web.HomeController do
  use RssRouter.Web, :controller

  def index(conn, _params) do
    feeds = RssRouter.FeedStore.get_feeds()
    latest_entries = RssRouter.FeedStore.get_all_latest_entries()
    render(conn, "index.html", feeds: feeds, latest_entries: latest_entries)
  end
end
