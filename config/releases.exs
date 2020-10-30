import Config

config :rss_router, RssRouter.Web.Endpoint,
  url: [
    host: System.fetch_env!("RSS_ROUTER_HOST"),
    path: System.fetch_env!("RSS_ROUTER_BASE_PATH")
  ],
  http: [port: 4000],
  secret_key_base: System.fetch_env!("RSS_ROUTER_SECRET_KEY_BASE"),
  server: true
