defmodule M.Finance do
  @moduledoc """
  M.Finance keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def app,
    do: elem(:application.get_application(__MODULE__), 1)

  def pubsub_finance,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_finance]

  def pubsub_accounting,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_accounting]

  def pubsub_env,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_env]

  def pubsub_member,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_member]

  def pubsub_sales_order,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_sales_order]
end
