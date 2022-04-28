defmodule M.Studio.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      M.StudioWeb.Telemetry,
      {Phoenix.PubSub, name: Studio.PubSub},
      M.StudioWeb.Endpoint,
      M.Studio.Worker
    ]

    opts = [strategy: :one_for_one, name: M.Studio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    M.StudioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
