defmodule M.Core.Common.Command do
  require M.Core.Common.Resource
  defmacro add_to(resource, %{} = params), do: %{params|resource: resource, command: :add_to}
	defmacro checkout(resource, %{} = params), do: %{params|resource: resource, command: :checkout}
	defmacro create(resource, %{} = params), do: %{params|resource: resource, command: :create}
  defmacro delete(resource, %{} = params), do: %{params|resource: resource, command: :delete}
  defmacro login(resource, %{} = params), do: %{params|resource: resource, command: :login}
  defmacro logout(resource, %{} = params), do: %{params|resource: resource, command: :logout}
  defmacro remove_from(resource, %{} = params), do: %{params|resource: resource, command: :remove_from}
  defmacro update(resource, %{} = params), do: %{params|resource: resource, command: :update}
end
