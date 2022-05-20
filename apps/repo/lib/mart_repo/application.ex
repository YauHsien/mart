defmodule M.Repo.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: M.Repo.Supervisor]
    Supervisor.start_link(children(), opts)
  end

  defp children() do
    [
      M.RepoWeb.Telemetry,
      Supervisor.child_spec({Phoenix.PubSub, name: M.Repo.pubsub_repo_query()}, id: :npub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Repo.pubsub_repo_command()}, id: :npub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Repo.pubsub_env()}, id: :npub_2),
      M.Repo.ReadOnlyRepo,
      M.Repo.Repo
      #M.RepoWeb.Endpoint,
      #M.Repo.QueryServer
    ]
  end

  @impl true
  def config_change(changed, _new, removed) do
    M.RepoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
