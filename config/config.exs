import Config

config :rss_router, :data_path, "./data"
config :rss_router, :pocket_consumer_key, :empty
config :rss_router, :pocket_access_token, :empty

import_config "#{Mix.env()}.secret.exs"
