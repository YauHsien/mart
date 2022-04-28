defmodule M.BackOffice do
  @moduledoc """
  M.BackOffice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def app,
    do: elem(:application.get_application(__MODULE__), 1)

  def pubsub_backoffice,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_backoffice]

  def pubsub_accounting,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_accounting]

  def pubsub_env,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_env]

  def pubsub_member,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_member]

  def pubsub_portfolio,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_portfolio]

  def pubsub_sales_order,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_sales_order]

  def pubsub_shop,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_shop]
end
