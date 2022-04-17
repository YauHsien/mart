defmodule M.Member.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    load_peer_nodes(:erlang.node())

    children = [
      # Start the Ecto repository
      M.Member.Repo,
      # Start the Telemetry supervisor
      M.MemberWeb.Telemetry,
      # Start the PubSub system
      Supervisor.child_spec({Phoenix.PubSub, name: M.Member.pub_sub()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Backoffice.pub_sub()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Env.pub_sub()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Finance.pub_sub()}, id: :pub_3),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Lobby.pub_sub()}, id: :pub_4),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Repo.pub_sub()}, id: :pub_5),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Studio.pub_sub()}, id: :pub_6),
      {Registry, keys: :unique, name: M.Member.Registry},
      # Start the Endpoint (http/https)
      M.MemberWeb.Endpoint,
      # Start a worker by calling: M.Member.Worker.start_link(arg)
      M.Member.Worker,
      {M.Member.Session.Registry, id: M.Member.Session.Registry}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Member.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    M.MemberWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def load_peer_nodes(:nonode@nohost), do: :ok
  def load_peer_nodes(_nodename) do
    Application.fetch_env!(:mart_member, :distribution)[:peer_nodes]
    |> Enum.map(&(
        if false == Enum.member?(:erlang.nodes(), &1) do
          try do
            :net_kernel.connect_node(&1)
          catch
            _ -> :ok
          end
        end ))
    :ok
  end
end
