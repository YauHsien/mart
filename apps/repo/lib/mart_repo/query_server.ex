defmodule M.Repo.QueryServer do
	use GenServer
  import  Ecto.Query
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoMessage
  alias M.Core.MartRepo
  alias M.Repo.ReadOnlyRepository, as: Repo
  alias M.Repo.SubscribingTopic
  alias MartRepo.User
  alias Phoenix.PubSub

  def start_link(args),
    do: GenServer.start_link(__MODULE__, args, name: Keyword.fetch!(args, :name))

  @query_channel M.Repo.pubsub_repo_query()

  @impl true

  def init(_args) do
    [
      SubscribingTopic.for_member(),
      SubscribingTopic.for_branding(),
      SubscribingTopic.for_portfolio(),
      SubscribingTopic.for_course(),
      SubscribingTopic.for_listing(),
      SubscribingTopic.for_sales()
    ]
    |> Enum.map(& PubSub.subscribe(@query_channel, &1))
    {:ok, %{}}
  end



  @impl true
  @spec handle_info(msg :: :timeout | term(), state :: term()) ::
  {:noreply, new_state}
  | {:noreply, new_state, timeout() | :hibernate | {:continue, term()}}
  | {:stop, reason :: term(), new_state}
  when new_state: term()

  def handle_info(msg, state)


  def handle_info(Common.RepoMessage.list(target), state) do

    list(target)
    |> Enum.map(&(
          PubSub.broadcast!(
            M.Repo.pubsub_repo_query,
            Common.RepoMessage.list(target) |> Common.RepoMessage.topic |> Common.RepoMessage.return,
            &1
          )
        ))

	  {:noreply, state}
  end


  def handle_info(Common.RepoMessage.aggregate(target, id), state) do

    _aggregate(target, id)
    |> Enum.map(&(
          PubSub.broadcast!(
            M.Repo.pubsub_repo_query,
            Common.RepoMessage.aggregate(target) |> Common.RepoMessage.topic |> Common.RepoMessage.return(id),
            &1
          )))

    {:noreply, state}
  end


  def handle_info(msg, state) do
    Logger.bare_log(:warning, msg)
    {:noreply, state}
  end



  #@spec list(atom()) :: [{:object, atom(), id: term()}]

  defp list(table),
    do: Repo.all(from t in table, select: t.id)
    |> Enum.map(&( {:object, table, id: &1} ))



  @spec _aggregate(atom(), term()) ::
  [
    {
      {:object, atom(), id: term()} |
      {:field, atom(), id: term(), field: atom(), value: term()}
    }
  ]

  defp _aggregate(table, id)


  defp _aggregate(User.Account, id) do

    account =
      Repo.one(from t in User.Account, where: t.id == ^id)
    |> Repo.preload(:user_tokens)

    [
      {:object, User.Account, id: id},
      {:field, User.Account, id: id, field: :username, value: account.username},
      {:field, User.Account, id: id, field: :password, value: account.password},
      {:field, User.Account, id: id, field: :salt, value: account.salt},
      {:field, User.Account, id: id, field: :password_changed_when, value: account.password_changed_when},
      {:field, User.Account, id: id, field: :user_token, value: account.user_token},
      {:field, User.Account, id: id, field: :expired_when, value: account.expired_when},
      {:field, User.Account, id: id, field: :inserted_at, value: account.inserted_at},
      {:field, User.Account, id: id, field: :update_at, value: account.updated_at}
    ] ++(
      account.user_tokens
      |> Enum.map(&([
            {:object, User.Token, id: &1.id},
            {:field, User.Token, id: &1.id, field: :user_token, value: &1.user_token},
            {:field, User.Token, id: &1.id, field: :expired_when, value: &1.expired_when},
            {:field, User.Token, id: &1.id, field: :inserted_at, value: &1.inserted_at},
            {:field, User.Token, id: &1.id, field: :updated_at, value: &1.updated_at}
          ])
      )
      |> List.flatten
    )
  end

end
