defmodule M.Domain.Stereotype.Repository do

  defmacro __using__(_opts) do
    quote do
      use GenServer

      def start_link(args) do
        {:ok, _} = Registry.start_link(keys: :unique, name: __MODULE__.Registry)
        GenServer.start_link(__MODULE__, args ++ [registry: __MODULE__.Registry])
      end

      def registry(repository), do: GenServer.call(repository, {:get, :registry}) |> elem(1)

      @impl true
      def init(opts) do
        registry = Keyword.get(opts, :registry)
        {:ok, %{registry: registry}}
      end

      @impl true
      def handle_call(request, from, state)

      def handle_call({:get, :registry}, _from, %{registry: registry} = state) do
        {:reply, {:ok, registry}, state}
      end

      def handle_call(request, _from, state), do: {:reply, {:bare, request}, state}
    end
  end
end
