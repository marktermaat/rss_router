defmodule RssRouter.Router.FeedService.FeedReader do
  @http_adapter Application.get_env(:rss_router, :http_adapter)

  def read_feed(uri) do
    @http_adapter.start()
    {:ok, %HTTPoison.Response{body: body}} = @http_adapter.get(uri, [], follow_redirect: true)

    {:ok, feed} =
      body
      |> String.replace(~r/src=".*?"/, "")
      |> Feedex.parse()

    feed
  end
end
