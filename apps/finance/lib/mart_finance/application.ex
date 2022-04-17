defmodule M.Finance.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      M.FinanceWeb.Telemetry,
      # Start the PubSub system
      Supervisor.child_spec({Phoenix.PubSub, name: M.Finance.pub_sub()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Accounting.pub_sub()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Env.pub_sub()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Member.pub_sub()}, id: :pub_3),
      Supervisor.child_spec({Phoenix.PubSub, name: M.SalesOrder.pub_sub()}, id: :pub_4),
      # Start the Endpoint (http/https)
      M.FinanceWeb.Endpoint,
      # Start a worker by calling: M.Finance.Worker.start_link(arg)
      M.Finance.Worker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Finance.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    M.FinanceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
