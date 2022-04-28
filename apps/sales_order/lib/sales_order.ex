defmodule M.SalesOrder do
  @moduledoc """
  Documentation for `M.SalesOrder`.
  """
  def app,
    do: elem(:application.get_application(__MODULE__), 1)

  def pubsub_accounting,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_accounting]

  def pubsub_backoffice,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_backoffice]

  def pubsub_env,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_env]

  def pubsub_finance,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_finance]

  def pubsub_lobby,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_lobby]

  def pubsub_repo_query,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_query]

  def pubsub_repo_command,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_command]
end
