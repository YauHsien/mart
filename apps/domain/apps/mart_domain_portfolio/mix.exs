defmodule M.Domain.Portfolio.MixProject do
  use Mix.Project

  def project do
    [
      app: :mart_domain_portfolio,
      version: "1.0.0",
      elixir: "~> 1.12",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {M.Domain.Application.PortfolioApplication, []}
    ]
  end

  defp deps do
    [
      {:mart_domain, in_umbrella: true}
    ]
  end
end