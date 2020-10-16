defmodule RssRouter.MixProject do
  use Mix.Project

  def project do
    [
      app: :rss_router,
      version: "0.1.0",
      elixir: "~> 1.11",
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
      {:pocketeer, "~> 0.1.5"}
    ]
  end
end
