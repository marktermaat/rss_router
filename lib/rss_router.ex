defmodule RssRouter do
  use Application

  def start(_type, _args) do
    children = [
      RssRouter.Router,
      RssRouterWeb.Endpoint
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
