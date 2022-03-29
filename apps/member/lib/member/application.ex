defmodule M.Member.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      M.Member.Repo,
      # Start the Telemetry supervisor
      M.MemberWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: M.Member.PubSub},
      # Start the Endpoint (http/https)
      M.MemberWeb.Endpoint
      # Start a worker by calling: M.Member.Worker.start_link(arg)
      # {M.Member.Worker, arg}
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
