defmodule M.Domain.MemberAggregate.UserAccountRepository do
  use M.Domain.Stereotype.Repository

  alias M.Core.Common
  import M.Domain.MemberAggregate.UserAccount, only: [
    username_tuple: 1,
    password_triple: 3,
    user_token_tuple: 1
  ]
  alias M.Domain.MemberAggregate.TokenServer
  alias M.Domain.MemberAggregate.UserAccount
  alias M.Domain.MemberAggregate.UserAccountServer

  @type t :: __MODULE__
  @type entry :: {t, Registry.key}

  @repo_write_pub_sub quote do: Application.fetch_env!(M.Domain.MixProject.project() |> Keyword.get(:app), :repo_write_pub_sub)



  @doc """
  Put a bare new user account to repository, then an user account with newly `id` will be returned.
  """
  @spec create_user_account(t(), UserAccount.t) :: {:ok, entry()} | {:error, term()}
  @spec create_user_account(UserAccount.t, t()) :: {:ok, entry()} | {:error, term()}

  def create_user_account(repository, %UserAccount{name: username} = user_account) do
    Common.command(@repo_write_pub_sub, @repo_write_pub_sub, "create user account", user_account)
    |> maybe_create_user_account(user_account, repository)
  end

  def create_user_account(%UserAccount{} = user_account, repository), do: create_user_account(repository, user_account)



  defp maybe_create_user_account(false, _, _), do: {:error, :no_repo}
  defp maybe_create_user_account(update, %UserAccount{name: username_tuple(username), user_token: user_token_tuple(token)} = user_account, repository) do

    ua_with_id = Map.merge(user_account, update)
    entry_name = encode(username)
    registry = registry(repository)

    GenServer.start_link(UserAccountServer, ua_with_id, name: {:via, Registry, {registry, entry_name}})
    |> maybe_put_token(token, registry, {:entry_name, entry_name})

    {:ok, {repository, entry_name}}
  end

  defp encode(term), do: term

  defp maybe_put_token({:ok, server}, token, registry, entry) do
    {:ok, _} = GenServer.start_link(TokenServer, entry, name: {:via, Registry, {registry, token}})
    :ok
  end
  defp maybe_put_token(_, _, _, _), do: :ok



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
