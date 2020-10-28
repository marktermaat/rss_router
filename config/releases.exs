import Config

config :rss_router, RssRouter.Web.Endpoint,
  url: [host: System.fetch_env!("RSS_ROUTER_HOST")],
  http: [port: System.fetch_env!("RSS_ROUTER_PORT")]
