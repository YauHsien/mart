defmodule M.Repo.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      M.Repo.Repo,
      M.RepoWeb.Telemetry,
      {Phoenix.PubSub, name: Repo.PubSub},
      M.RepoWeb.Endpoint,
      M.Repo.QueryServer
    ]

    opts = [strategy: :one_for_one, name: M.Repo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    M.RepoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
