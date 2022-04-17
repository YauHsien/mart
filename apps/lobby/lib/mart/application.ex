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
      Supervisor.child_spec({Phoenix.PubSub, name: M.Lobby.pub_sub()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Accounting.pub_sub()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Env.pub_sub()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Member.pub_sub()}, id: :pub_3),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Portfolio.pub_sub()}, id: :pub_4),
      Supervisor.child_spec({Phoenix.PubSub, name: M.SalesOrder.pub_sub()}, id: :pub_5),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Shop.pub_sub()}, id: :pub_6),
      {Registry, keys: :unique, name: M.Lobby.Registry},
      # Start the Endpoint (http/https)
      M.LobbyWeb.Endpoint,
      # Start a worker by calling: M.Lobby.Worker.start_link(arg)
      # {M.Lobby.Worker, arg}
      {M.Shop, name: :host, shop_id: :host, channel: M.Lobby.PubSub},
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
