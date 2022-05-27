defmodule M.Domain.MemberAggregate.TokenServer do
  use GenServer

  @impl true
  def init({:entry_name, entry_name}),
    do: {:ok, %{entry_name: entry_name}}

  def init(_args),
    do: {:stop, {:error, :badarg}}

  @impl true
  def handle_call(request, from, state)

  def handle_call({:get_entry, registry}, _from, %{entry_name: entry_name} = state) do
    case Registry.lookup(registry, entry_name) do
      [] -> {:error, :not_found}
      [{_, server}] -> {:ok, server}
    end
    |> then(&( {:reply, &1, state} ))
  end

  def handle_call(request, _from, state), do: {:reply, {:bare, request}, state}
end
