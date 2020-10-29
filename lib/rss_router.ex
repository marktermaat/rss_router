defmodule RssRouter do
  use Application

  def start(_type, _args) do
    children = [
      RssRouter.Router.ServicePids,
      RssRouter.Router.Supervisor,
      RssRouter.Web.Endpoint,
      {Task, &RssRouter.Router.Supervisor.start_initial_feeds/0}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
