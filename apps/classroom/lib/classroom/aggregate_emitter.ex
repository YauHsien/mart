defmodule M.Classroom.AggregateEmitter do
  @doc """
  To generate Classroom.Aggregate-s.

  All generated aggregates are collected in M.Classroom.Registry.
  """
  use GenServer
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoCommand
  alias   M.Core.Common.RepoCommand
  alias Phoenix.PubSub

  @registry M.Classroom.Registry


  @spec start_link(Keyword.t()) :: on_start

  def start_link(args), do: GenServer.start_link(__MODULE__, args)



  @impl true
  @spec init(Keyword.t()) :: {:ok, map()} | {:stop, term()}

  def init(_args) do

    aggregate = M.Repo.Course

    Common.repo_read_pub_sub_name()
    |> PubSub.subscribe(Common.RepoCommand.list(aggregate) |> Common.topic() |> Common.return())

    Common.repo_read_pub_sub_name()
    |> PubSub.broadcast!(
      Common.RepoCommand.list(aggregate) |> Common.topic()
      Common.RepoCommand.list(aggregate)
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
        value = {id: id}
        Registry.register(@registry, key, value)

        {:ok, pid} = M.Classroom.Aggregate.start_link(id: id)
        key = {:aggregate_root, aggregate, id: id}
        value = pid
        Registry.registry(@register, key, value)

      [{self(), _}] ->
        :ok
    end

    {:noreply, state}
  end


  def handle_info(_msg, state),
    do: {:noreply, state}




end
