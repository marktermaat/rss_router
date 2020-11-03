defmodule RssRouter.Router.Supervisor do
  alias RssRouter.FeedData
  alias RssRouter.Router.PidsService
  alias RssRouter.Router.FeedService
  alias RssRouter.Router.FeedService.RoutingRule
  alias RssRouter.Router.Publisher.PocketPublisher

  def start_initial_feeds() do
    IO.puts("Seeding initial feeds")

    store_initial_feeds()

    FeedData.get_feeds()
    |> Enum.each(&start_feed_service/1)
  end

  def start_feed_service(uri) do
    child_spec = {FeedService, %RoutingRule{uri: uri, publisher: PocketPublisher}}

    DynamicSupervisor.start_child(RssRouter.Router.DynamicSupervisor, child_spec)
  end

  def stop_feed_service(uri) do
    pid = PidsService.get_pid(uri)
    :ok = DynamicSupervisor.terminate_child(RssRouter.Router.DynamicSupervisor, pid)
  end

  defp store_initial_feeds() do
    (System.get_env("FEEDS") || "")
    |> String.split(" ")
    |> Enum.reject(fn f -> String.length(f) == 0 end)
    |> Enum.each(&FeedData.insert_feed/1)
  end
end
