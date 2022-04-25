defmodule M.Env.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require M.Core.Common
  alias M.Core.Common
  alias M.Core.Node


  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      M.EnvWeb.Telemetry,
      # Start the PubSub system
      Supervisor.child_spec({Phoenix.PubSub, name: Common.env_pub_sub_name()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.repo_read_pub_sub_name()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.repo_write_pub_sub_name()}, id: :pub_2),
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
