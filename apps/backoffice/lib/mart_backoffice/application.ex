defmodule M.BackOffice.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      M.BackOfficeWeb.Telemetry,
      {Phoenix.PubSub, name: BackOffice.PubSub},
      {Registry, keys: :unique, name: M.BackOffice.Registry},
      M.BackOfficeWeb.Endpoint,
      M.BackOffice.Worker
    ]

    opts = [strategy: :one_for_one, name: M.BackOffice.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    M.BackOfficeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
