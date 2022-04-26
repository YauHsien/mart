defmodule M.Member.AggregateEmitter do
  @doc """
  To generate Member.Aggregate-s.

  All generated aggregates are collected in M.Member.Registry.
  """
  use GenServer
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoCommand
  alias Phoenix.PubSub

  @registry M.Member.Registry


  @spec start_link(Keyword.t()) :: GenServer.on_start

  def start_link(args), do: GenServer.start_link(__MODULE__, args)



  @impl true
  @spec init(Keyword.t()) :: {:ok, map()} | {:stop, term()}

  def init(_args) do

    aggregate = M.Repo.User.Account

    Common.repo_read_pub_sub_name()
    |> PubSub.subscribe(Common.RepoCommand.list(aggregate) |> Common.RepoCommand.topic() |> Common.RepoCommand.return())

    Common.repo_read_pub_sub_name()
    |> PubSub.broadcast!(
      Common.RepoCommand.list(aggregate) |> Common.RepoCommand.topic(),
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
        value = id
        Registry.register(@registry, key, value)

        {:ok, pid} = M.Member.Aggregate.start_link(id: id)
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
