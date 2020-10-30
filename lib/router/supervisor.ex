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
    |> Enum.each(&start_feed_service/1)
  end

  def start_feed_service(uri) do
    child_spec =
      {RssRouter.Router.FeedService,
       %RssRouter.Router.RoutingRule{uri: uri, publisher: RssRouter.Router.PocketPublisher}}

    DynamicSupervisor.start_child(RssRouter.Router.Supervisor, child_spec)
  end

  def stop_feed_service(uri) do
    pid = RssRouter.Router.ServicePids.get_pid(uri)
    :ok = DynamicSupervisor.terminate_child(RssRouter.Router.Supervisor, pid)
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
