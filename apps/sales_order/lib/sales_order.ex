defmodule M.SalesOrder do
  @moduledoc """
  Documentation for `M.SalesOrder`.
  """

  defmacro pub_sub(), do: M.SalesOrder.PubSub
end
