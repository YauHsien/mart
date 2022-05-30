defmodule M.Domain.MixProject do
  use Mix.Project

  def project do
    [
      app: :mart_domain,
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
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_domain_toolkit, "~> 0.1.0", github: "YauHsien/ex_domain_toolkit", branch: "main"},
      {:phoenix_pubsub, "~> 2.1.1"},
      {:plug_crypto, "~> 1.2.2"},
      {:typed_struct, "~> 0.1.4"},
      {:uuid, "~> 1.1"},
      {:mart_core, "~> 0.1.0", app: false, path: "../../../core"}
    ]
  end
end
