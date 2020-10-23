defmodule RssRouter.Router.Supervisor do
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
    IO.puts("Seeding initial feeds")

    get_initial_feeds()
    |> Enum.map(fn feed ->
      {RssRouter.Router.FeedService,
       %RssRouter.Router.RoutingRule{uri: feed, publisher: RssRouter.Router.PocketPublisher}}
    end)
    |> Enum.each(fn child -> DynamicSupervisor.start_child(Router.Supervisor, child) end)
  end

  defp get_initial_feeds() do
    RssRouter.Config.initial_feeds()
    |> String.split(" ")
    |> Enum.concat(RssRouter.FeedStore.get_feeds())
    |> Enum.reject(fn f -> String.length(f) == 0 end)
  end
end
