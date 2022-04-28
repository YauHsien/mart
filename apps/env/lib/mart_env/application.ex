defmodule M.Env.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      M.EnvWeb.Telemetry,
      {Phoenix.PubSub, name: Env.PubSub},
      {Registry, keys: :unique, name: M.Env.Registry},
      M.EnvWeb.Endpoint,
      M.Env.Server
    ]

    opts = [strategy: :one_for_one, name: M.Env.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    M.EnvWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
