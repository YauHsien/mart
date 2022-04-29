defmodule M.SalesOrder.AggregateEmitter do
  @doc """
  To generate SalesOrder.Aggregate-s.

  All generated aggregates are collected in M.SalesOrder.Registry.
  """
  use GenServer
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoMessage
  alias Phoenix.PubSub

  @registry M.SalesOrder.Registry


  @spec start_link(Keyword.t()) :: GenServer.on_start

  def start_link(args), do: GenServer.start_link(__MODULE__, args)



  @impl true
  @spec init(Keyword.t()) :: {:ok, map()} | {:stop, term()}

  def init(_args) do

    aggregate = M.Repo.SalesOrder

    M.SalesOrder.pubsub_repo_query()
    |> PubSub.subscribe(Common.RepoMessage.list(aggregate) |> Common.RepoMessage.topic() |> Common.RepoMessage.return())

    M.SalesOrder.pubsub_repo_query()
    |> PubSub.broadcast!(
      Common.RepoMessage.list(aggregate) |> Common.RepoMessage.topic(),
      Common.RepoMessage.list(aggregate)
    )

    {:ok, %{
        aggregate: aggregate
     }}
  end



  @impl true
  @spec handle_info(msg :: :timeout | term(), state :: term()) ::
  {:noreply, new_state}
  | {:noreply, new_state, timeout() | :hibernate | {:continue, term()}}
  | {:stop, reason :: term(), new_state}
  when new_state: term()

  def handle_info(msg, state)


  def handle_info({:object, aggregate, id: id}, %{aggregate: aggregate} = state) do

    case Registry.lookup(@registry, {:object, aggregate, id: id}) do
      [] ->

        key = {:aggregate_root, aggregate}
        value = id
        Registry.register(@registry, key, value)

        {:ok, pid} = M.SalesOrder.Aggregate.start_link(id: id)
        key = {:aggregate_root, aggregate, id: id}
        value = pid
        Registry.register(@registry, key, value)

      [{pid, _}] when pid == self() ->
        :ok
    end

    {:noreply, state}
  end


  def handle_info(_msg, state),
    do: {:noreply, state}




end
