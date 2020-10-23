defmodule RssRouter do
  use Application

  alias RssRouter.Router.Supervisor, as: RouterSupervisor

  def start(_type, _args) do
    children = [
      RouterSupervisor,
      RssRouter.Web.Endpoint,
      {Task, &RouterSupervisor.start_initial_feeds/0}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
