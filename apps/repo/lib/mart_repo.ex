defmodule M.Repo do
  @moduledoc """
  M.Repo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  defmacro pub_sub, do: M.Repo.PubSub
end
