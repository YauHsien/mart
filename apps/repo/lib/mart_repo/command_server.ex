defmodule M.Repo.CommandServer do
  use GenServer
  import Ecto.Query
  require Logger
  alias M.Core.DataCache
  alias M.Core.MartRepo
  alias M.Domain.Member
  alias M.Repo.ReadWriteRepository, as: Repo
  alias M.Repo.SubscribingTopic
  alias DataCache.UserAccountAccessMessage
  alias MartRepo.User.Account, as: UserAccount
  alias MartRepo.User.Account.HandlingEvent, as: UserAccountHadlingEvent
  alias MartRepo.User.Token, as: UserToken
  alias Member.HandlingEventEntity
  alias Member.PasswordValue
  alias Member.UserAccountAggregate
  alias Member.UserTokenValue
  alias UserAccountAggregate.Protocol, as: UserAccountAggregateProtocol
  alias Phoenix.PubSub

  def start(args),
    do: GenServer.start_link(__MODULE__, args, name: Keyword.fetch!(args, :name))

  @query_channel M.Repo.pubsub_repo_query()
  @command_channel M.Repo.pubsub_repo_command()

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
    |> Enum.map(& PubSub.subscribe(@command_channel, &1))
    {:ok, %{}}
  end

  @impl true
  def handle_info(msg, state)

  def handle_info(
    %UserAccountAccessMessage{
      message:
      {:new,
       %UserAccountAggregate{
         id: nil,
         name: name,
         password:
         %PasswordValue{salt: salt, enc_pass: enc_pass, last_changed: last_changed},
         user_token:
         %UserTokenValue{salt: salt, enc_token: enc_token, expired_when: expired_when},
         using_history: []
       }},
      return_topic: ReturnTopic
    },
    state
  ) do
    ua_changeset =
      UserAccount.changeset(%UserAccount{},
        %{username: name, salt: salt, password: enc_pass, password_changed_when: last_changed,
          user_token: enc_token, expired_when: expired_when}
      )
    ut_changeset =
      UserToken.changeset(%UserToken{},
        %{user_token: enc_token, expired_when: expired_when}
      )
    he_changeset =
      UserAccountHadlingEvent.changeset(%UserAccountHadlingEvent{},
        %{time: NaiveDateTime.utc_now(), event: "#{inspect {:new, name}}"}
      )
    {:ok, user} = Repo.insert(ua_changeset)
    {:ok, _} = Repo.insert(%UserToken{ut_changeset | user_account_id: user.id})
    {:ok, handling_event} =
      Repo.insert(%UserAccountHadlingEvent{he_changeset | user_account_id: user.id})
    # Return new user account aggregate
    user
    |> UserAccountAggregateProtocol.transfer_from([handling_event | user.using_history])
    |> then(& PubSub.broadcast!(Macro.expand(@query_channel, __MODULE__), ReturnTopic, &1) )
    {:noreply, state}
  end

  def handle_info(msg, state) do
    Logger.bare_log(:warning, msg)
    {:noreply, state}
  end
end
