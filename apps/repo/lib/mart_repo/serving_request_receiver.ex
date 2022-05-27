defmodule M.Repo.ServingRequestReceiver do
  defmacro __using__(domain: domain) do
    quote do
      use GenServer
      alias M.Repo.SubscribingTopic, as: Topic
      alias Phoenix.PubSub

      def start_link(args), do: GenServer.start_link(__MODULE__, args,
            name: Keyword.fetch!(args, :name))

      @impl true
      def init(args) do
        Keyword.fetch!(args, :pubsub_query)
        |> PubSub.subscribe(unquote("Topic.for_" <> to_string(domain)))
        {:ok,
         %{
           query_server: Keyword.fetch!(args, :query_server)
         }}
      end

      @spec invoke_query(state, Ecto.Queryable.t() | Ecto.Schema.t())
      :: {:ok, term()} | {:error, term()} when state: map()
      defp invoke_query(state, query) do
        state
        |> Map.fetch!(:query_server)
        |> GenServer.call(query)
      end
    end
  end
end
