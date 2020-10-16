defmodule RssRouter.PocketPublisher do
  @behaviour RssRouter.Publisher

  @consumer_key Application.fetch_env!(:rss_router, :pocket_consumer_key)
  @access_token Application.fetch_env!(:rss_router, :pocket_access_token)

  @impl RssRouter.Publisher
  def publish(title, uri) do
    IO.puts("Publishing #{title}: #{uri}")
    :ok
  end
end
