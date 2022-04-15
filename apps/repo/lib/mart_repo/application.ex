defmodule M.Repo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require M.Repo

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      M.Repo.Repo,
      # Start the Telemetry supervisor
      M.RepoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: M.Repo.pub_sub()},
      # Start the Endpoint (http/https)
      M.RepoWeb.Endpoint
      # Start a worker by calling: M.Repo.Worker.start_link(arg)
      # {M.Repo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Repo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    M.RepoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
