defmodule RssRouter.Router.Publisher.PocketPublisher do
  @behaviour RssRouter.Router.Publisher

  @impl RssRouter.Router.Publisher
  def publish(title, uri) do
    client = %Pocketeer.Client{
      consumer_key: pocket_consumer_key(),
      access_token: pocket_access_token(),
      site: "https://getpocket.com"
    }

    {:ok, _item} = Pocketeer.add(client, %{url: uri, title: title})

    :ok
  end

  defp pocket_consumer_key() do
    Application.fetch_env!(:rss_router, :pocket_consumer_key)
  end

  defp pocket_access_token() do
    Application.fetch_env!(:rss_router, :pocket_access_token)
  end
end
