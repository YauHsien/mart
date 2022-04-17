defmodule M.SalesOrder.MixProject do
  use Mix.Project

  def project do
    [
      app: :mart_sales_order,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {M.SalesOrder.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:phoenix_pubsub, "~> 2.1.1"},
      {:mart_backoffice, app: false, path: "../backoffice"},
      {:mart_core, app: false, path: "../core"},
      {:mart_env, app: false, path: "../env"},
      {:mart_finance, app: false, path: "../finance"},
      {:mart, app: false, path: "../lobby"},
      {:mart_repo, app: false, path: "../repo"}
    ]
  end
end
