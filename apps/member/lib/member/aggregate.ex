defmodule M.Member.Aggregate do
  @doc """
  Member Aggregate.
  """
  use GenServer
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoCommand
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
    |> PubSub.subscribe(Common.RepoCommand.aggregate(@aggregate) |> Common.RepoCommand.topic() |> Common.RepoCommand.return())

    M.Member.pubsub_repo_query()
    |> PubSub.broadcast!(
      Common.RepoCommand.aggregate(@aggregate) |> Common.RepoCommand.topic(),
    Common.RepoCommand.aggregate(@aggregate, id)
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


  def handle_info({:field, M.Repo.User.Account, id: _id, field: _field, value: _value0}, state) do
    # TODO
    {:noreply, state}
  end


  def handle_info({:object, M.Repo.User.Token, id: _id, field: _field, value: _value0}, state) do
    # TODO
    {:noreply, state}
  end


  def handle_info({:field, M.Repo.User.Token, id: _id, field: _field, value: _value0}, state) do
    # TODO
    #key = {:field, table, id: id, field: field}
    #value = value0
    #Registry.register(@registry, key, value)

    {:noreply, state}
  end


  def handle_info(_msg, state),
    do: {:noreply, state}




end
