defmodule M.Member.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require M.Core.Common
  alias M.Core.Common
  alias M.Core.Node


  @impl true
  def start(_type, _args) do

    Node.connect_node([Application.fetch_env!(:mart_member, :node_env)])

    children = [
      # Start the Ecto repository
      M.Member.Repo,
      # Start the Telemetry supervisor
      M.MemberWeb.Telemetry,
      # Start the PubSub system
      Supervisor.child_spec({Phoenix.PubSub, name: Common.member_pub_sub_name()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.backoffice_pub_sub_name()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.env_pub_sub_name()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.finance_pub_sub_name()}, id: :pub_3),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.lobby_pub_sub_name()}, id: :pub_4),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.repo_pub_sub_name()}, id: :pub_5),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.studio_pub_sub_name()}, id: :pub_6),
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

end
