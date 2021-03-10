defmodule RssRouterWeb.Router do
  use Phoenix.Router
  import Plug.Conn
  import Phoenix.Controller

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/rss", RssRouterWeb do
    pipe_through(:browser)

    get("/", HomeController, :index)
    post("/add_feed", HomeController, :add_feed)
    get("/delete/:feed", HomeController, :delete)
    get("/json", HomeController, :list_json)
  end
end
