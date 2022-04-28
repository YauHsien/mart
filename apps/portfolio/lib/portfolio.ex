defmodule M.Portfolio do
  @moduledoc """
  Documentation for `M.Portfolio`.
  """
  def app,
    do: elem(:application.get_application(__MODULE__), 1)

  def pubsub_portfolio,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_portfolio]

  def pubsub_backoffice,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_backoffice]

  def pubsub_env,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_env]

  def pubsub_finance,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_finance]

  def pubsub_repo_query,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_query]

  def pubsub_repo_command,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_repo_command]

  def pubsub_studio,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_studio]
end
