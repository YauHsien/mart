defmodule M.Lobby do
  @moduledoc """
  M.Lobby keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def app,
    do: Application.get_application(M.Lobby.Application)

  def pubsub_domain,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_domain]

  def pubsub_lobby,
    do: Application.fetch_env!(app(), :node_resources)[:pubsub_lobby]
end
