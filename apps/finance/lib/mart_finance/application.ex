defmodule M.Finance.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      M.FinanceWeb.Telemetry,
      {Phoenix.PubSub, name: Finance.PubSub},
      {Registry, keys: :unique, name: M.Finance.Registry},
      M.FinanceWeb.Endpoint,
      M.Finance.Worker
    ]

    opts = [strategy: :one_for_one, name: M.Finance.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    M.FinanceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
