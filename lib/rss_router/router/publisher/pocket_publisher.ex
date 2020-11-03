defmodule RssRouter.Router.Publisher.PocketPublisher do
  @behaviour RssRouter.Router.Publisher

  @pocket_consumer_key Application.fetch_env!(:rss_router, :pocket_consumer_key)
  @pocket_access_token Application.fetch_env!(:rss_router, :pocket_access_token)

  @impl RssRouter.Router.Publisher
  def publish(title, uri) do
    client = %Pocketeer.Client{
      consumer_key: @pocket_consumer_key,
      access_token: @pocket_access_token,
      site: "https://getpocket.com"
    }

    {:ok, _item} = Pocketeer.add(client, %{url: uri, title: title})

    :ok
  end
end
