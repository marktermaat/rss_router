defmodule RssRouter.Router do
  use Supervisor

  alias RssRouter.Router.PidsService

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      PidsService,
      {DynamicSupervisor,
       strategy: :one_for_one, name: RssRouter.Router.DynamicSupervisor, max_restarts: 100},
      {Task, &RssRouter.Router.Supervisor.start_initial_feeds/0}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start_feed_service(uri) do
    RssRouter.Router.Supervisor.start_feed_service(uri)
  end

  def stop_feed_service(uri) do
    RssRouter.Router.Supervisor.stop_feed_service(uri)
  end
end
