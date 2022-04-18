defmodule M.Env.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require M.Core.Common
  alias M.Core.Common

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      M.EnvWeb.Telemetry,
      # Start the PubSub system
      Supervisor.child_spec({Phoenix.PubSub, name: Common.env_pub_sub_name()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.accounting_pub_sub_name()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.backoffice_pub_sub_name()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.finance_pub_sub_name()}, id: :pub_3),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.lobby_pub_sub_name()}, id: :pub_4),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.member_pub_sub_name()}, id: :pub_5),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.portfolio_pub_sub_name()}, id: :pub_6),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.repo_pub_sub_name()}, id: :pub_7),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.sales_order_pub_sub_name()}, id: :pub_8),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.shop_pub_sub_name()}, id: :pub_9),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.studio_pub_sub_name()}, id: :pub_10),
      # Start the Endpoint (http/https)
      M.EnvWeb.Endpoint,
      # Start a worker by calling: M.Env.Worker.start_link(arg)
      # {M.Env.Worker, arg},
      M.Env.Server
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Env.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    M.EnvWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
