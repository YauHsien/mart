defmodule M.Lobby.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      M.LobbyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: M.Lobby.PubSub},
      {Registry, keys: :unique, name: M.Lobby.Registry},
      # Start the Endpoint (http/https)
      M.LobbyWeb.Endpoint,
      # Start a worker by calling: M.Lobby.Worker.start_link(arg)
      # {M.Lobby.Worker, arg}
      {M.Shop, name: :host, channel: M.Lobby.PubSub},
      M.LobbyWeb.Controllers.PubSub.Receiver
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Lobby.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    M.LobbyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
