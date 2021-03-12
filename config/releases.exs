import Config

config :rss_router, RssRouterWeb.Endpoint,
  url: [
    host: System.fetch_env!("RSS_ROUTER_HOST")
  ],
  http: [port: 4000],
  secret_key_base: System.fetch_env!("RSS_ROUTER_SECRET_KEY_BASE"),
  server: true

config :rss_router, :username, System.fetch_env!("RSS_ROUTER_USERNAME")
config :rss_router, :password, System.fetch_env!("RSS_ROUTER_PASSWORD")
config :rss_router, :data_path, System.fetch_env!("DATA_PATH")
config :rss_router, :pocket_consumer_key, System.fetch_env!("POCKET_CONSUMER_KEY")
config :rss_router, :pocket_access_token, System.fetch_env!("POCKET_ACCESS_KEY")
config :rss_router, :api_token, System.fetch_env!("API_TOKEN")
