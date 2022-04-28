defmodule M.Studio do
  @moduledoc """
  M.Studio keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def app,
    do: elem(:application.get_application(__MODULE__), 1)

  def pubsub_studio,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_studio]

  def pubsub_classroom,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_classroom]

  def pubsub_env,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_env]

  def pubsub_member,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_member]

  def pubsub_portfolio,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_portfolio]
end
