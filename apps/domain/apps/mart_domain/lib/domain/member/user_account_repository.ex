import YDToolkit
alias M.Core.Common
alias M.Core.DataCache
alias M.Domain.Member
alias M.Domain.RepoSubscribingTopic
alias DataCache.UserAccountAccessMessage
alias DataCache.ReturnTopic
alias DataCache.TopicProtocol
alias Member.UserAccountAggregate
alias Member.UserAccountRepository
alias Member.Protocol
alias Phoenix.PubSub

defprotocol Protocol do

  @doc """
  Initial a user record.
  """
  @spec new(UserAccountRepository.t, UserAccountAggregate.t) :: UserAccountAggregate.t
  def new(repo, user)
	#TODO: need impl.

end

repository UserAccountRepository do

  use TypedStruct
  typedstruct do
    field :id, :term, default: NaiveDateTime.utc_now()
  end

  defimpl Protocol do

    @spec new(UserAccountRepository.t, UserAccountAggregate.t) :: UserAccountAggregate.t
    def new(repo, user), do: UserAccountRepository.new(repo, user)
    #TODO: need impl.
  end

  @query_channel M.Domain.pubsub_repo_query()
  @command_channel M.Domain.pubsub_repo_command()

  @impl true
  def handle_info(msg, state)

  def handle_info({:query_channel, query_channel}, state),
    do: %{state | query_channel: query_channel}
    |> then(& {:noreply, &1})

  def handle_info({:command_channel, command_channel}, state),
    do: %{state | command_channel: command_channel}
    |> then(& {:noreply, &1})

  def handle_info({:subscribe, return_topic}, state) do
    PubSub.subscribe(state.query_channel, return_topic)
    {:noreply, state}
  end

  def handle_info(_msg, state), do: {:noreply, state}

  @spec new(UserAccountRepository.t, UserAccountAggregate.t) :: UserAccountAggregate.t
  def new(repo, user) do
    new_user = {:new, user}
    |> then(& UserAccountAccessMessage.create(TopicProtocol.create(%ReturnTopic{on_domain: &1.domain})))
    |> then(& Common.command(@query_channel, @command_channel, RepoSubscribingTopic.for_member(), &1))
    new_user
    |> maybe_put_to(repo)
    new_user
  end

  @spec maybe_put_to(map_or_false, repo)
  :: :ok | {:error, term}
  when map_or_false: map() | false,
    repo: UserAccountRepository.t

  defp maybe_put_to(false, _repo), do: :ok
  defp maybe_put_to(map, repo),
    do: GenServer.call(repo, {:put_entry, Map.get(map, :id), map})


  @spec find_user_account(t, String.t) :: {:ok, entry()} | {:error, term()}

  def find_user_account(repository, token) do
    registry = registry(repository)
    case Registry.lookup(registry, token) do
      [] -> {:error, :not_found}
      [{_, server}] ->
        case GenServer.call(server, {:get_entry, registry}) do
          {:ok, entry_name} -> {:ok, {repository, entry_name}}
          other -> other
        end
    end
  end



  @spec find_user_account(t(), String.t, String.t) :: {:ok, entry()} | {:error, term()}

  def find_user_account(repository, username, password) do
    entry_name = encode(username)
    case Registry.lookup(registry(repository), entry_name) do
          [] -> {:error, :not_found}
          [{_, server}] ->

            case GenServer.call(server, {:verify_password, password}) do
              :ok -> {:ok, {repository, entry_name}}
              :invalid -> {:error, :not_found}
            end
    end
  end

  defp encode(x), do: x


end
