defmodule RssRouterWeb.Router do
  use Phoenix.Router
  import Plug.Conn
  import Phoenix.Controller

  pipeline :browser do
    plug(:auth)
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["application/json"])
    plug(RssRouterWeb.Plugs.AuthPlug)
  end

  scope "/rss", RssRouterWeb do
    pipe_through(:browser)

    get("/", HomeController, :index)
    post("/add_feed", HomeController, :add_feed)
    get("/delete/:feed", HomeController, :delete)
  end

  scope "/rss/api", RssRouterWeb do
    pipe_through(:api)

    get("/", ApiController, :index)
    post("/", ApiController, :post)
    delete("/", ApiController, :delete)
  end

  defp auth(conn, _opts) do
    username = Application.fetch_env!(:rss_router, :username)
    password = Application.fetch_env!(:rss_router, :password)
    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end
end
