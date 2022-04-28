defmodule Mart.MixProject do
  use Mix.Project

  def project do
    [
      app: :mart_all_in_one,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [
        :logger,
        :phoenix_pubsub,
        :node_resources,
        :mart_env,
        :mart_repo,
        :mart_accounting,
        :mart_classroom,
        :mart_member,
        :mart_portfolio,
        :mart_sales_order,
        :mart_shop,
        :mart,
        :mart_studio,
        :mart_backoffice,
        :mart_finance
      ]
    ]
  end

  defp deps do
    [
      {:mart_accounting, app: false, path: "../../apps/accounting"},
      {:mart_backoffice, app: false, path: "../../apps/backoffice"},
      {:mart_classroom, app: false, path: "../../apps/classroom"},
      {:mart_env, app: false, path: "../../apps/env"},
      {:mart_finance, app: false, path: "../../apps/finance"},
      {:mart, app: false, path: "../../apps/lobby"},
      {:mart_member, app: false, path: "../../apps/member"},
      {:mart_portfolio, app: false, path: "../../apps/portfolio"},
      {:mart_repo, app: false, path: "../../apps/repo"},
      {:mart_sales_order, app: false, path: "../../apps/sales_order"},
      {:mart_shop, app: false, override: true, path: "../../apps/shop"},
      {:mart_studio, app: false, path: "../../apps/studio"},
      {:node_resources, ">= 1.0.0", github: "YauHsien/beamsprawl", branch: "main", sparse: "node_resources"},
      {:phoenix_pubsub, ">= 2.1.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end
end
