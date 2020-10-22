defmodule RssRouter do
  use Application

  def start(_type, _args) do
    children = [
      RssRouter.Supervisor,
      RssRouter.Web.Endpoint,
      {Task, &RssRouter.Supervisor.start_initial_feeds/0}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
