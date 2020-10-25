defmodule RssRouter.Web.HomeController do
  use RssRouter.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
