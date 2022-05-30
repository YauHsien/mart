defmodule M.Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :mart_core,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.8.2"},
      {:ex_domain_toolkit, "~> 0.1.0", github: "YauHsien/ex_domain_toolkit", branch: "main"},
      {:jason, "~> 1.2"},
      {:timex, "~> 3.7.7"},
      {:typed_struct, "~> 0.1.4"},
      {:phoenix_pubsub, "~> 2.1.1"},
      {:plug_crypto, "~> 1.2.2"}
    ]
  end
end
