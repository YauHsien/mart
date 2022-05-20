defmodule M.Repo.Repo1 do
  use Ecto.Repo,
    otp_app: :mart_repo,
    adapter: Ecto.Adapters.Postgres
  #alias M.Repo.Basket
  #alias M.Repo.Bought
  #alias M.Repo.Course
  #alias M.Repo.Lecturer
  #alias M.Repo.Lession
  #alias M.Repo.Payment
  #alias M.Repo.Pricing
  #alias M.Repo.Promotion
  alias M.Repo.Repo
  #alias M.Repo.SalesOrder
  #alias M.Repo.Shop
  #alias M.Repo.SKU
  #alias M.Repo.Studentship
  #alias M.Repo.Tutorship
  #alias M.Repo.User

  import Ecto.Query
  alias Ecto
  alias Ecto.Multi
  alias M.Core.Common
  alias M.Repo.User.Account
  alias NaiveDateTime

  def user_accounts() do
    from(a in Account)
    |> Repo.all()
    |> Repo.preload(:user_tokens)
  end

  @spec create(any, any) :: Ecto.Multi.t()
  def create(username, password) do
    salt =
      UUID.uuid5(:nil, "password salt:"|>Common.get_uuid())
    user_token =
      UUID.uuid5(:nil, "user token:"|>Common.get_uuid())
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

  @spec maybe_update(token0::String.t()) :: {:ok, token::String.t(), expired_when::String.t()} | {:error, issue::String.t()}
  def maybe_update(token) do
    case from(a in Account, where: a.user_token == ^token)
    |> Repo.one() do
      nil ->
        nil
      account ->
        if NaiveDateTime.compare(Map.get(account,:expired_when), NaiveDateTime.local_now()) == :lt do
          account
          |> change_user_token()
          |> then(&( {:ok,Map.get(&1,:user_token),Map.get(&1,:expired_when)} ))
        else
          {:ok, Map.get(account,:user_token), Map.get(account,:expired_when)}
        end
    end
  end

  @spec signin(username::String.t(), password::String.t()) :: {:ok,Account.t()} | {:error,:failed}
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
            account
            |> then(&( {:ok, change_user_token(&1)} ))
        end
    end
  end

  @spec change_user_token(account0::%Account{}) :: (account::%Account{})
  defp change_user_token(account) do
    user_token =
      UUID.uuid5(:nil, "user token:"|>Common.get_uuid())
    Multi.new()
    |> Multi.update(:user_account, Account.changeset(account,%{user_token: user_token}))
    |> Multi.insert(:user_token, fn %{user_account: account} ->
      Ecto.build_assoc(account, :user_tokens, user_token: account.user_token, expired_when: account.expired_when)
    end)
    |> Repo.transaction()
    |> elem(1)
    |> Map.get(:user_account)
  end

  def verify(_token) do
    #Repo.update
    nil
  end

end
