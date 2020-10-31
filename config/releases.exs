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
