defmodule M.Domain.MixProject do
  use Mix.Project

  def project do
    [
      app: :mart_domain,
      version: "1.0.0",
      elixir: "~> 1.12",
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
      {:plug_crypto, "~> 1.2.2"},
      {:typed_struct, "~> 0.1.4"},
      {:mart_core, app: false, path: "../core"}
    ]
  end
end
