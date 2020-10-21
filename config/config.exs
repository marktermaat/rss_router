import Config

config :logger,
  backends: [:console, {LoggerFileBackend, :error_log}]

config :logger, :console, level: :all

config :logger, :error_log,
  level: :error,
  path: "#{System.get_env("LOG_PATH") || "log"}/error.log"

config :rss_router, :data_path, "./data"
config :rss_router, :pocket_consumer_key, :empty
config :rss_router, :pocket_access_token, :empty

import_config "#{Mix.env()}.secret.exs"
