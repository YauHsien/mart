defmodule M.Member.Repo do
  use Ecto.Repo,
    otp_app: :member,
    adapter: Ecto.Adapters.Postgres
  import Ecto.Query
  alias Ecto
  alias Ecto.Multi
  alias M.Member, as: App
  alias M.Member.Repo
  alias M.Member.Session.Timespan
  alias M.Member.User.Account
  alias M.Member.User.Token
  alias UUID

  def user_accounts() do
    from(a in Account)
    |> Repo.all()
    |> Repo.preload(:user_tokens)
  end

  @spec create(any, any) :: Ecto.Multi.t()
  def create(username, password) do
    salt =
      UUID.uuid5(:nil, "password salt:"|>App.get_uuid())
    user_token =
      UUID.uuid5(:nil, "user token:"|>App.get_uuid())
    Multi.new()
    |> Multi.insert(:user_account, %{
          username: username,
          password: password,
          salt: salt,
          user_token: user_token
                    }
                    |> then(&(Account.changeset(%Account{}, &1)))
    )
    |> Multi.insert(:user_token, fn %{user_account: account} ->
      Ecto.build_assoc(account, :user_tokens, user_token: account.user_token, expired_when: account.expired_when)
    end)
    |> Repo.transaction()
  end

  def signin(token) do
    #from(a in Account, where: a.user_token == ^token)
    #|> Repo.all()
    #Repo.update
    nil
  end

  @spec signin(username::String.t(), password::String.t()) :: {:ok,%Account{}} | {:error,:failed}
  def signin(username, password) do
    case from(a in Account, where: a.username == ^username)
    |> Repo.one() do
      nil ->
        {:error, :failed}
      account ->
        case Account.verify!(account, password) do
          false ->
            {:error, :failed}
          true ->
            user_token =
              UUID.uuid5(:nil, "user token:"|>App.get_uuid())
            Multi.new()
            |> Multi.update(:user_account, Account.changeset(account,%{user_token: user_token}))
            |> Multi.insert(:user_token, fn %{user_account: account} ->
              Ecto.build_assoc(account, :user_tokens, user_token: account.user_token, expired_when: account.expired_when)
            end)
            |> Repo.transaction()
            |> then(&( {:ok, elem(&1,1)|>Map.get(:user_account)} ))
        end
    end
  end

  def verify(token) do
    #Repo.update
    nil
  end
end
