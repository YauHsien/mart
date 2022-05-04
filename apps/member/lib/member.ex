defmodule M.Member do
  @moduledoc """
  M.Member keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Timex.Timezone

  def get_uuid(category) do
    Timezone.local().full_name|>DateTime.now!()|>to_string()|>then(&(category<>&1))
  end

  def app,
    do: elem(:application.get_application(__MODULE__), 1)

  def pubsub_member,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_member]

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

  def pubsub_studio,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_studio]
end
