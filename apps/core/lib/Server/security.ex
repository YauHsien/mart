defmodule M.Core.Server.Security do
  @spec get_public_key(set :: atom()) :: any()
  defmacro get_public_key(set), do: Application.fetch_env!(set, :server_security)[:public_key]
  @spec get_private_key(set :: atom()) :: any()
  defmacro get_private_key(set), do: Application.fetch_env!(set, :server_security)[:private_key]
end
