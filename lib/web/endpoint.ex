defmodule RssRouter.Web.Endpoint do
  use Phoenix.Endpoint, otp_app: :rss_router
  import Plug.BasicAuth

  plug(:basic_auth, username: "hello", password: "secret")
  plug(RssRouter.Web.Router)
end
