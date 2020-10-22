defmodule RssRouter.Web.Endpoint do
  use Phoenix.Endpoint, otp_app: :rss_router

  plug(RssRouter.Web.Router)
end
