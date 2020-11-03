defmodule RssRouter.Router.FeedService do
  use GenServer

  alias RssRouter.Router.PidsService
  alias RssRouter.Router.FeedService.FeedProcessor

  @ten_minutes 600_000

  @impl true
  def init(rule) do
    PidsService.set_pid(rule.uri, self())
    schedule_processing(3_000)
    {:ok, rule}
  end

  def start_link(rule) do
    GenServer.start_link(__MODULE__, rule)
  end

  @doc """
  Process the items of this RSS feed
  """
  @impl true
  def handle_info(:process_feed, rule) do
    process_feed(rule)

    {:noreply, rule}
  end

  defp process_feed(rule) do
    FeedProcessor.process_feed(rule)

    schedule_processing()
  end

  defp schedule_processing(timeout \\ @ten_minutes) do
    Process.send_after(self(), :process_feed, timeout)
  end
end
