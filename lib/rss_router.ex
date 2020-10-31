defmodule RssRouter do
  use Application

  def start(_type, _args) do
    children = [
      RssRouter.ServicePids,
      RssRouter.Supervisor,
      RssRouterWeb.Endpoint,
      {Task, &RssRouter.Supervisor.start_initial_feeds/0}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
