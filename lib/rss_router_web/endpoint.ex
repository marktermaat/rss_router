defmodule RssRouterWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :rss_router

  @session_options [
    store: :cookie,
    key: "rss_router_test_key",
    signing_salt: System.get_env("RSS_ROUTER_SIGNING_SALT") || "wJ2D06w5"
  ]

  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Jason)
  plug(Plug.Session, @session_options)
  plug(RssRouterWeb.Router)
end
