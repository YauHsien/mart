defmodule M.Core.Common.Command do

  @spec add_to(term(), map()) :: map()
  def add_to(resource, params),
    do: Map.merge(params, %{resource: resource, command: :add_to})

  @spec checkout(term(), map()) :: map()
	def checkout(resource, params),
    do: Map.merge(params, %{resource: resource, command: :checkout})

  @spec create(term(), map()) :: map()
	def create(resource, params),
    do: Map.merge(params, %{resource: resource, command: :create})

  @spec delete(term(), map()) :: map()
  def delete(resource, params),
    do: Map.merge(params, %{resource: resource, command: :delete})

  @spec login(term(), map()) :: map()
  def login(resource, params),
    do: Map.merge(params, %{resource: resource, command: :login})

  @spec logout(term(), map()) :: map()
  def logout(resource, params),
    do: Map.merge(params, %{resource: resource, command: :logout})

  @spec remove_from(term(), map()) :: map()
  def remove_from(resource, params),
    do: Map.merge(params, %{resource: resource, command: :remove_from})

  @spec update(term(), map()) :: map()
  def update(resource, params),
    do: Map.merge(params, %{resource: resource, command: :update})
end
