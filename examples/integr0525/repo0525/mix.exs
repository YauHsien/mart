defmodule Repo0525.MixProject do
  use Mix.Project

  def project do
    [
      app: :repo0525,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :sprawl, :phoenix_pubsub, :node_resources, :mart_repo]
    ]
  end

  defp deps do
    [
      {:sprawl, "~> 1.0.0", override: true, github: "YauHsien/beamsprawl", sparse: "sprawl"},
      {:node_resources, "~> 1.0.0", app: false, github: "YauHsien/beamsprawl", sparse: "node_resources"},
      {:phoenix_pubsub, ">= 2.1.1"},
      {:mart_repo, "~> 0.1.0", app: false, path: "../../../../mart/apps/repo"}
    ]
  end

end
