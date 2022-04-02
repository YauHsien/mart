defmodule M.Member.Repo do
  use Ecto.Repo,
    otp_app: :member,
    adapter: Ecto.Adapters.Postgres
  import Ecto.Query
  alias Ecto.Multi
  alias M.Member.Repo
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
      UUID.uuid5(:nil, "password salt")
    user_token =
      UUID.uuid5(:nil, "user_token")
    Multi.new()
    |> Multi.insert(:user_account, %{
          username: username,
          password: password,
          salt: salt,
          user_token: user_token
                    }
                    |> then(&(Account.changeset(%Account{}, &1)))
    )
    |> Repo.transaction()
  end

  def signin(token) do
    #from(a in Account, where: a.user_token == ^token)
    #|> Repo.all()
    #Repo.update
    nil
  end

  def signin(username, password) do
    #Repo.update
    nil
  end

  def verify(token) do
    #Repo.update
    nil
  end
end
