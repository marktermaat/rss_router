defmodule RssRouter.PocketPublisher do
  @behaviour RssRouter.Publisher

  @impl RssRouter.Publisher
  def publish(title, uri) do
    client = %Pocketeer.Client{
      access_token: RssRouter.Config.pocket_access_token(),
      consumer_key: RssRouter.Config.pocket_consumer_key(),
      site: "https://getpocket.com"
    }

    {:ok, _item} = Pocketeer.add(client, %{url: uri, title: title})

    :ok
  end
end
