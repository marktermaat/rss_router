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

  def start_feed_processor(feed) do
    rule = %RssRouter.Router.RoutingRule{uri: feed, publisher: RssRouter.Router.PocketPublisher}

    DynamicSupervisor.start_child(
      RssRouter.Router.Supervisor,
      {RssRouter.Router.FeedService, rule}
    )
  end

  def start_initial_feeds() do
    IO.puts("Seeding initial feeds")

    get_initial_feeds()
    |> Enum.map(fn feed ->
      {RssRouter.Router.FeedService,
       %RssRouter.Router.RoutingRule{uri: feed, publisher: RssRouter.Router.PocketPublisher}}
    end)
    |> Enum.each(fn child -> DynamicSupervisor.start_child(RssRouter.Router.Supervisor, child) end)
  end

  defp get_initial_feeds() do
    store_initial_feeds()

    RssRouter.FeedStore.get_feeds()
  end

  defp store_initial_feeds() do
    RssRouter.Config.initial_feeds()
    |> String.split(" ")
    |> Enum.reject(fn f -> String.length(f) == 0 end)
    |> Enum.each(&RssRouter.FeedStore.insert_feed/1)
  end
end
