defmodule M.Lobby.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    children = [
      M.LobbyWeb.Telemetry,
      {Phoenix.PubSub, name: Lobby.PubSub},
      {Registry, keys: :unique, name: M.Lobby.Registry},
      M.LobbyWeb.Endpoint,
      {M.Shop, name: :host, shop_id: :host, channel: M.Lobby.pubsub_lobby()},
      M.Lobby.Worker,
      M.LobbyWeb.Controllers.PubSub.Receiver
    ]

    opts = [strategy: :one_for_one, name: M.Lobby.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    M.LobbyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
