defmodule M.Member.AggregateServer do
  @doc """
  Member Aggregate.
  """
  use GenServer
  require Logger
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoMessage
  alias Phoenix.PubSub

  #@registry M.Member.Registry
  @aggregate M.Repo.User.Account

  #defstruct id: 0,
  #  username: "",
  #  salt: "",
  #  password: "",
  #  password_changed_when: nil,
  #  user_token: "",
  #  expired_when: nil,
  #  user_tokens: [] # list of M.Member.Aggregate.UserToken

  #defmodule M.Member.Aggregate.UserToken,
  #  do: defstruct id: 0,
  #    user_token: "",
  #    expired_when: nil



  @spec start_link(Keyword.t()) :: GenServer.on_start

  def start_link(args), do: GenServer.start_link(__MODULE__, args)



  @impl true
  @spec init(Keyword.t()) :: {:ok, map()} | {:stop, term()}

  def init(args) do

    id = Keyword.get(args, :id)

    M.Member.pubsub_repo_query()
    |> PubSub.subscribe(Common.RepoMessage.aggregate(@aggregate) |> Common.RepoMessage.topic() |> Common.RepoMessage.return(id))

    M.Member.pubsub_repo_query()
    |> PubSub.broadcast!(
      Common.RepoMessage.aggregate(@aggregate) |> Common.RepoMessage.topic(),
    Common.RepoMessage.aggregate(@aggregate, id)
    )

    {:ok, %{
        aggregate: @aggregate,
        id: id
     }}
  end



  @impl true
  @spec handle_info(msg :: :timeout | term(), state :: term()) ::
  {:noreply, new_state}
  | {:noreply, new_state, timeout() | :hibernate | {:continue, term()}}
  | {:stop, reason :: term(), new_state}
  when new_state: term()

  def handle_info(msg, state)


  def handle_info(Common.RepoMessage.field(M.Repo.User.Account, id, _field, _value0) = msg, %{id: id} = state) do
    # TODO
    Logger.warn("#{id} and #{inspect msg}")
    {:noreply, state}
  end


  def handle_info(Common.RepoMessage.object(M.Repo.User.Token, _id) = msg, %{id: id} = state) do
    # TODO
    Logger.warn("#{id} and #{inspect msg}")
    {:noreply, state}
  end


  def handle_info(Common.RepoMessage.field(M.Repo.User.Token, _id, _field, _value0) = msg, %{id: id} = state) do
    # TODO
    Logger.warn("#{id} and #{inspect msg}")
    #key = {:field, table, id: id, field: field}
    #value = value0
    #Registry.register(@registry, key, value)

    {:noreply, state}
  end


  def handle_info(_msg, state),
    do: {:noreply, state}




end
