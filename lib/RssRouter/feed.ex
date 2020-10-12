defmodule RssRouter.Feed do
  use GenServer

  @ten_minutes 600_000

  @impl true
  def init(uri) do
    process_feed(uri)
    {:ok, [uri]}
  end

  def start_link(uri) do
    GenServer.start_link(__MODULE__, uri)
  end

  @doc """
  Process the items of this RSS feed
  """
  @impl true
  def handle_info(:process_feed, uri) do
    process_feed(uri)
    {:noreply, uri}
  end

  defp process_feed(uri) do
    IO.puts("Processing feed #{uri}")
    schedule_processing()
  end

  defp schedule_processing(timeout \\ @ten_minutes) do
    Process.send_after(self(), :process_feed, timeout)
  end
end
