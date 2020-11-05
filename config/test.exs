import Config

config :rss_router, :data_path, "./test"
config :rss_router, http_adapter: Shared.FakeAdapter
