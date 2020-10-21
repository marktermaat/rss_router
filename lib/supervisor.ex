defmodule RssRouter.Supervisor do
  use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    sup = DynamicSupervisor.init(strategy: :one_for_one)
    sup
  end

  def start_initial_feeds() do
    get_initial_feeds()
    |> Enum.map(fn feed ->
      {RssRouter.FeedService,
       %RssRouter.RoutingRule{uri: feed, publisher: RssRouter.PocketPublisher}}
    end)
    |> Enum.each(fn child -> DynamicSupervisor.start_child(RssRouter.Supervisor, child) end)
  end

  defp get_initial_feeds() do
    (System.get_env("FEEDS") || "")
    |> String.split(" ")
    |> Enum.concat(RssRouter.FeedStore.get_feeds())
    |> Enum.reject(fn f -> String.length(f) == 0 end)
  end
end
