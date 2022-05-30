defmodule M.Repo.ServingRequestReceiver do
  alias M.Repo.SubscribingTopic, as: Topic
  @topics quote do: [
    member: Topic.for_member(),
    branding: Topic.for_branding(),
    portfolio: Topic.for_portfolio(),
    course: Topic.for_course(),
    listing: Topic.for_listing(),
    sales: Topic.for_sales()
  ]
  defmacro __using__(domain: domain) do
    quote do
      use GenServer
      alias Phoenix.PubSub

      def start_link(args), do: GenServer.start_link(__MODULE__, args,
            name: Keyword.fetch!(args, :name))

      @impl true
      def init(args) do
        Keyword.fetch!(args, :pubsub_server)
        |> PubSub.subscribe(Keyword.fetch!(unquote(@topics), unquote(domain)))
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
