import Config

config :rss_router, :data_path, "./data"

import_config "#{Mix.env()}.exs"
