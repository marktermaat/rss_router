defmodule RssRouter.Web.Endpoint do
  use Phoenix.Endpoint, otp_app: :rss_router
  import Plug.BasicAuth

  @session_options [
    store: :cookie,
    key: "rss_router_test_key",
    signing_salt: "wJ2D06w5"
  ]

  plug(:basic_auth, username: "hello", password: "secret")
  plug(Plug.Session, @session_options)
  plug(RssRouter.Web.Router)
end
