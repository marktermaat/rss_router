defmodule RssRouter.Web.HomeController do
  use RssRouter.Web, :controller

  def index(conn, _params) do
    feeds = RssRouter.FeedStore.get_feeds()
    render(conn, "index.html", feeds: feeds)
  end
end
