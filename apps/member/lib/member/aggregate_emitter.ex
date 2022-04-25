defmodule M.Member.AggregateEmitter do
  @doc """
  To generate Member.Aggregate-s.

  All generated aggregates are collected in M.Member.Registry.
  """
  use GenServer
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoCommand
  alias   M.Core.Common.RepoCommand
  alias Phoenix.PubSub

  @registry M.Member.Registry


  @spec start_link(Keyword.t()) :: on_start

  def start_link(args), do: GenServer.start_link(__MODULE__, args)



  @impl true
  @spec init(Keyword.t()) :: {:ok, map()} | {:stop, term()}

  def init(_args) do

    [RepoCommand.repo_query()]
    |> Enum.map(&(
          Common.repo_read_pub_sub_name()
          |> PubSub.suscribe(&1)
        ))

    {:ok, %{}}
  end



  @impl true
  @spec handle_info(msg :: :timeout | term(), state :: term()) ::
  {:noreply, new_state}
  | {:noreply, new_state, timeout() | :hibernate | {:continue, term()}}
  | {:stop, reason :: term(), new_state}
  when new_state: term()

  def handle_info(msg, state)


  def handle_info({:object, table, id: id}, state) do

    case Registry.lookup(@registry, {:object, table, id: id}) do
      [] ->

        key = {:object, table}
        value = {id: id}
        Registry.register(@registry, key, value)

        {:ok, pid} = M.Member.Aggregate.start_link(id: id)
        key = {:object, table, id: id}
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
