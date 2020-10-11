defmodule RssRouter.Feed do
  use GenServer

  @impl true
  def init(uri) do
    schedule()
    {:ok, [uri]}
  end

  def start_link(uri) do
    GenServer.start_link(__MODULE__, uri)
  end

  @impl true
  def handle_info(:process_feed, state) do
    IO.puts("Working")
    schedule()
    {:noreply, state}
  end

  defp schedule() do
    IO.puts("Scheduling")
    Process.send_after(self(), :process_feed, 10_000)
  end
end
