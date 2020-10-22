defmodule RssRouter.Config do
  @pocket_consumer_key Application.fetch_env!(:rss_router, :pocket_consumer_key)
  @pocket_access_token Application.fetch_env!(:rss_router, :pocket_access_token)

  def data_path() do
    System.get_env("DATA_PATH") || Application.fetch_env!(:rss_router, :data_path)
  end

  def pocket_consumer_key() do
    System.get_env("POCKET_CONSUMER_KEY") || @pocket_consumer_key
  end

  def pocket_access_token() do
    System.get_env("POCKET_ACCESS_KEY") || @pocket_access_token
  end

  def initial_feeds() do
    System.get_env("FEEDS") || ""
  end
end
