defmodule RssRouter.Web.HomeController do
  use Phoenix.Controller, namespace: RssRouter.Web

  def index(conn, _params) do
    Phoenix.Controller.html(conn, "RssRouter")
  end
end
