defmodule RssRouter.Web.Router do
  use Phoenix.Router

  get("/", RssRouter.Web.HomeController, :index)
end
