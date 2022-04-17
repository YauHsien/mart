defmodule M.Member do
  @moduledoc """
  M.Member keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Timex.Timezone
  alias UUID

  defmacro pub_sub(), do: M.Member.pub_sub()


  def get_uuid(category) do
    Timezone.local().full_name|>DateTime.now!()|>to_string()|>then(&(category<>&1))
  end
end
