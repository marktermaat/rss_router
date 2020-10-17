defmodule RssRouter.PocketPublisher do
  @behaviour RssRouter.Publisher

  @consumer_key Application.fetch_env!(:rss_router, :pocket_consumer_key)
  @access_token Application.fetch_env!(:rss_router, :pocket_access_token)

  @impl RssRouter.Publisher
  def publish(title, uri) do
    client = %Pocketeer.Client{
      access_token: @access_token,
      consumer_key: @consumer_key,
      site: "https://getpocket.com"
    }

    {:ok, _item} = Pocketeer.add(client, %{url: uri, title: title})

    :ok
  end
end
