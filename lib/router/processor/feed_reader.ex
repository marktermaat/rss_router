defmodule RssRouter.Router.FeedReader do
  def read_feed(uri) do
    HTTPoison.start()
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(uri, [], follow_redirect: true)

    {:ok, feed} =
      body
      |> String.replace(~r/src=".*?"/, "")
      |> Feedex.parse()

    feed
  end
end
