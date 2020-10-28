defmodule RssRouter.Web.Endpoint do
  use Phoenix.Endpoint, otp_app: :rss_router
  import Plug.BasicAuth

  @session_options [
    store: :cookie,
    key: "rss_router_test_key",
    signing_salt: System.fetch_env!("RSS_ROUTER_SIGNING_SALT") || "wJ2D06w5"
  ]

  plug(:basic_auth,
    username: System.fetch_env!("RSS_ROUTER_USERNAME") || "admin",
    password: System.fetch_env!("RSS_ROUTER_PASSWORD") || "secret"
  )

  plug(Plug.Session, @session_options)
  plug(RssRouter.Web.Router)
end
