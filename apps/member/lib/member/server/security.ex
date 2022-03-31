defmodule M.Member.Server.Security do
  defmacro get_public_key, do: Application.fetch_env!(:member, :server_security)[:public_key]
  defmacro get_private_key, do: Application.fetch_env!(:member, :server_security)[:private_key]
end
