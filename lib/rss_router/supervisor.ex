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
    IO.puts("Seeding initial feeds")

    get_initial_feeds()
    |> Enum.each(&start_feed_service/1)
  end

  def start_feed_service(uri) do
    child_spec =
      {RssRouter.FeedService,
       %RssRouter.RoutingRule{uri: uri, publisher: RssRouter.PocketPublisher}}

    DynamicSupervisor.start_child(RssRouter.Supervisor, child_spec)
  end

  def stop_feed_service(uri) do
    pid = RssRouter.ServicePids.get_pid(uri)
    :ok = DynamicSupervisor.terminate_child(RssRouter.Supervisor, pid)
  end

  defp get_initial_feeds() do
    store_initial_feeds()

    RssRouter.FeedData.get_feeds()
  end

  defp store_initial_feeds() do
    initial_feeds()
    |> String.split(" ")
    |> Enum.reject(fn f -> String.length(f) == 0 end)
    |> Enum.each(&RssRouter.FeedData.insert_feed/1)
  end

  defp initial_feeds() do
    System.get_env("FEEDS") || ""
  end
end
