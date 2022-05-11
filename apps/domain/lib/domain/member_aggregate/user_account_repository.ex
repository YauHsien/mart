defmodule M.Domain.MemberAggregate.UserAccountRepository do
  use M.Domain.Stereotype, :repository

  alias M.Core.Common
  import M.Domain.MemberAggregate.UserAccount, only: [
    password_triple: 3,
    user_token_tuple: 1
  ]
  alias M.Domain.MemberAggregate.UserAccount
  alias M.Domain.MemberAggregate.UserAccountServer

  @type t :: __MODULE__
  @repo_write_pub_sub quote do: Application.fetch_env!(M.Domain.MixProject.project() |> Keyword.get(:app), :repo_write_pub_sub)



  @doc """
  Put a bare new user account to repository, then an user account with newly `id` will be returned.
  """
  @spec create_user_account(UserAccount.t) :: UserAccount.t

  def create_user_account(user_account),
    do: Common.command(@repo_write_pub_sub, @repo_write_pub_sub, "create user account", user_account)
    |> then(&( %UserAccount{user_account | id: &1.id} ))

  def test() do
    :test
  end

  def find_user_account(repository, name),
    do: :hello



  #@spec find_user_account(t, name) :: {:ok, UserAccountServer.t} | {:error, :not_found}
  #when name: String.t

  def find_user_account(repository, name) do
    case Registry.lookup(registry(repository), name) do
          [] -> {:error, :not_found}
          [{_, user_account}] -> {:ok, user_account}
    end
  end



  @spec find_user_account(t, entry_name, password) :: {:ok, entry_name} | {:error, :not_found}
  when entry_name: String.t, password: String.t

  def find_user_account(repository, entry_name, password) do
    case Registry.lookup(registry(repository), entry_name) do
          [] -> {:error, :not_found}
          [{_, user_account_server}] ->

            case GenServer.call(user_account_server, {:verify_password, password}) do
              :ok -> {:ok, entry_name}
              :invalid -> {:error, :not_found}
            end
    end
  end



  @spec save_password(t, String.t) :: :ok | {:error, reason :: term()}

  def save_password(repository, name) do
    case Registry.lookup(registry(repository), name) do
          [] -> {:error, :not_found}
          [{_, %{password: password_triple(password, salt, changed_when)}}] ->
            Common.command(@repo_write_pub_sub, @repo_write_pub_sub, "save password", {password, salt, changed_when})
    end
  end



  @spec save_user_token(t, String.t) :: :ok | {:error, reason :: term()}

  def save_user_token(repository, entry_name) do
    case Registry.lookup(registry(repository), entry_name) do
          [] -> {:error, :not_found}
          [{_, %{user_token: user_token_tuple(user_token)}}] ->
            Common.command(@repo_write_pub_sub, @repo_write_pub_sub, "save user token", user_token)
    end
  end


end
