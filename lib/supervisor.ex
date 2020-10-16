defmodule RssRouter.Supervisor do
  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    sup = DynamicSupervisor.init(strategy: :one_for_one)
    # start_initial_feeds()
    sup
  end

  def start_initial_feeds() do
    RssRouter.FeedStore.get_feeds()
    |> Enum.map(fn feed ->
      {RssRouter.FeedService, %RssRouter.RoutingRule{uri: feed, publisher: :none}}
    end)
    |> Enum.each(fn child -> DynamicSupervisor.start_child(RssRouter.Supervisor, child) end)
  end
end
