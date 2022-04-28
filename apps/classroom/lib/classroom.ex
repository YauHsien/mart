defmodule M.Classroom do
  @moduledoc """
  Documentation for `M.Classroom`.
  """
  def app,
    do: elem(:application.get_application(__MODULE__), 1)

  def pubsub_classroom,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_classroom]

  def pubsub_env,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_env]

  def pubsub_repo_query,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_query]

  def pubsub_repo_command,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_command]

  def pubsub_studio,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_studio]
end
