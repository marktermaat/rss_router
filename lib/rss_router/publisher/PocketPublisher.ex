defmodule RssRouter.PocketPublisher do
  @behaviour RssRouter.Publisher

  @impl RssRouter.Publisher
  def publish(title, uri) do
    IO.puts("Publishing #{title}: #{uri}")
    :ok
  end
end
