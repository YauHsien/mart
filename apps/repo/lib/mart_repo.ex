defmodule M.Repo do
  @moduledoc """
  M.Repo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def app,
    do: Application.get_application(M.Repo.Application) ||
      Keyword.fetch!(__MODULE__.MixProject.project, :app)

  def node_resources, do: Application.fetch_env!(app(), :node_resources)

  def pubsub_env,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_env]

  def pubsub_repo_query,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_query]

  def pubsub_repo_command,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_command]
end
