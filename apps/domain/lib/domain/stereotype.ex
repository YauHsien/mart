defmodule M.Domain.Stereotype do

  defmacro __using__(opts)

  defmacro __using__(:aggregate_root) do
    quote do
      def stereotype, do: :aggregate_root
      def is_aggregate, do: true
      def is_entity, do: true
      def is_value_object, do: false
    end
  end

  defmacro __using__(:value_object) do
    quote do
      def stereotype, do: :value_object
      def is_aggregate, do: false
      def is_entity, do: false
      def is_value_object, do: true
    end
  end

  defmacro __using__(:entity) do
    quote do
      def stereotype, do: :entity
      def is_aggregate, do: false
      def is_entity, do: true
      def is_value_object, do: false
    end
  end

  defmacro __using__(:repository) do
    quote do
      def stereotype, do: :repository
      def is_aggregate, do: false
      def is_entity, do: false
      def is_value_object, do: false

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
