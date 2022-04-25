defmodule M.Member.Aggregate do
  @doc """
  Member Aggregate.
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

  def init(args) do

    id = Keyword.get(args, :id)

    [RepoCommand.repo_query()]
    |> Enum.map(&(
          Common.repo_read_pub_sub_name()
          |> PubSub.suscribe(&1)
        ))

    {:ok, %{}}
  end

  # Aggregate User-Account
  #
  # root: :user_account
  #       - list of :user_token


  @impl true
  @spec handle_info(msg :: :timeout | term(), state :: term()) ::
  {:noreply, new_state}
  | {:noreply, new_state, timeout() | :hibernate | {:continue, term()}}
  | {:stop, reason :: term(), new_state}
  when new_state: term()

  def handle_info(msg, state)


  def handle_info({:field, table, id: id, field: field, value: value0}, state) do

    key = {:field, table, id: id, field: field}
    value = value0
    Registry.register(@registry, key, value)

    {:noreply, state}
  end


  def handle_info({:relation, parent, id: id, child, dhild_id: child_id}, state) do

    key = {:relation, parent, child}
    value = {:id: id, child_id: child_id}
    Registry.register(@registry, key, value)

    {:noreply, state}
  end


  def handle_info(_msg, state),
    do: {:noreply, state}




end
