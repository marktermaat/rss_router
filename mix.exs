defmodule RssRouter.MixProject do
  use Mix.Project

  def project do
    [
      app: :rss_router,
      version: "0.1.0",
      elixir: "~> 1.10",
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :pocketeer],
      mod: {RssRouter, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:feedex, "~> 0.1.4"},
      {:pocketeer, "~> 0.1.5"},
      {:poison, "~> 3.0"},
      {:logger_file_backend, "~> 0.0.11"},
      {:jason, "~> 1.2.2"},
      {:phoenix, "~> 1.5"},
      {:plug_cowboy, "~> 2.4"},
      {:phoenix_html, "~> 2.14"}
    ]
  end
end
