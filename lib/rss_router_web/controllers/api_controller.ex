defmodule RssRouterWeb.ApiController do
  use RssRouterWeb, :controller

  import Plug.Conn

  def index(conn, _params) do
    latest_entries = RssRouter.FeedData.get_all_latest_entries()
    json(conn, Enum.into(latest_entries, %{}))
  end

  def post(conn, params) do
    {:ok, feed} = Map.fetch(params, "feed")
    RssRouter.FeedData.insert_feed(feed)
    RssRouter.Router.start_feed_service(feed)
    conn |> send_resp(:ok, "")
  end

  def delete(conn, params) do
    {:ok, feed} = Map.fetch(params, "feed")
    RssRouter.FeedData.delete_feed(feed)
    RssRouter.Router.stop_feed_service(feed)
    conn |> send_resp(:ok, "")
  end
end
