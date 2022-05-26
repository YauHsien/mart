defmodule M.Domain do
  @moduledoc """
  Documentation for `M.Domain`.
  """

  def app,
    do: Application.get_application(M.Domain.Application)

  def pubsub_repo_query,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_query]

  def pubsub_repo_command,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_command]

  def pubsub_domain,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_domain]

  def pubsub_lobby,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_lobby]

end
