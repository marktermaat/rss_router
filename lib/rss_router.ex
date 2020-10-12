defmodule RssRouter do
  use Application

  @moduledoc """
  Documentation for `RssRouter`.
  """

  def start(_type, _args) do
    children = [
      RssRouter.Supervisor,
      {Task, &RssRouter.Supervisor.start_initial_feeds/0}
    ]

    Supervisor.start_link(children, strategy: :rest_for_one)
  end

  # def get_rss_body do
  #   HTTPoison.start()

  #   {:ok, %HTTPoison.Response{body: body}} =
  #     HTTPoison.get("http://feeds.feedburner.com/tweakers/mixed")

  #   body
  # end

  # def parse_rss(body) do
  #   {:ok, feed, _} = FeederEx.parse(body)
  #   feed
  # end
end
