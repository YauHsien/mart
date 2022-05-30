# TODO: Deprecated
defmodule M.Domain.MemberAggregate.UserAccount do

  alias M.Domain.Branding.TutoringBrand
  alias M.Domain.Customer
  alias M.Domain.MemberAggregate.UserAccountRepository
  alias M.Domain.MemberAggregate.UserAccountServer
  alias M.Domain.MemberAggregate.UserTokenHistory
  alias Plug.Crypto



  use TypedStruct
  @typedoc """
  Object: UserAccount (Aggregate root)
  Aggregate: Member
  """
  typedstruct do
    field :id, :integer, default: nil
    field :inserted_at, NaiveDateTime.t()
    field :updated_at, NaiveDateTime.t()
    field :name, MemberAggregate.username(), enforce: true
    field :password, MemberAggregate.password(), enforce: true
    field :user_token, MemberAggregate.user_token(), enforce: true
    field :token_history, [UserTokenHistory.t], default: []
    field :tutoring_brands, [TutoringBrand.t], default: []
    field :customer, Customer.t
  end



  @max_age 86400



  defmacro username_tuple(name), do: quote do: {:username, unquote(name)}

  defmacro password_triple(password, salt, changed_when),
    do: quote do: {:password, unquote(password), unquote(salt), unquote(changed_when)}

  defmacro user_token_tuple(user_token), do: quote do: {:user_token, unquote(user_token)}



  @doc """
  Create a bare new user account
  """
  @spec create(UserAccountRepository.t, String.t, String.t) :: {:ok, UserAccountRepository.entry} | {:error, term()}

  def create(repository, username, password) do

    datetime = NaiveDateTime.utc_now()

    {:password, enc_pass, salt, _} =
      pac_pass =
      create_password(username, password, datetime)

    enc_token = Crypto.sign(enc_pass, salt, username, max_age: @max_age)

    %__MODULE__{
      name: username_tuple(username),
      password: pac_pass,
      user_token: user_token_tuple(enc_token)
    }
    |> UserAccountRepository.create_user_account(repository)
  end



  @doc """
  Find some existing user account.
  """
  @spec find(UserAccountRepository.t, String.t, String.t) :: {:ok, UserAccountRepository.entry()} | {:error, term()}

  def find(repository, username, password), do: UserAccountRepository.find_user_account(repository, username, password)



  @doc """
  Find some existing user account by token.
  """
  @spec find(UserAccountRepository.t, String.t) :: {:ok, UserAccountRepository.entry()} | {:error, term()}

  def find(repository, token), do: UserAccountRepository.find_user_account(repository, token)



  #@doc """
  #Set user password according to the old one.
  #"""
  #@spec set_password(UserAccountRepository.entry, old_password, password) :: t
  #when old_password: String.t, password: String.t

  #def set_password(repository_entry, old_password, password) do

  #  case UserAccountRepository.find_user_account(repository_entry, user_account_name) do
  #    {:error, :not_found} -> {:error, :not_found}
  #    {:ok, server} ->

  #      case UserAccountServer.verify_and_set_password(server, old_password, password) do
  #        {:ok, _user_account_1} ->

  #          UserAccountRepository.save_password(repository, user_account_name)

  #        {:error, reason} -> {:error, reason}
  #      end
  #  end
  #end



  # Open for import.
  def create_password(username, password, datetime) do

    salt =
      datetime
      |> NaiveDateTime.to_gregorian_seconds()
      |> elem(1)
      |> Integer.to_string(16)
    enc_pass = Crypto.sign(password, salt, username)

    password_triple(enc_pass, salt, datetime)
  end




  @doc """
  Get a new user token.

  If the parameter `user_token` is given, it's to renew a token.
  """
  @spec get_user_token(UserAccountRepository.t, String.t) :: {:ok, String.t} | {:error, :invalid}
  @spec get_user_token(UserAccountRepository.t, entry_name, user_token) :: {:ok, maybe_new_token} | {:error, :invalid}
  when entry_name: String.t, user_token: String.t, maybe_new_token: String.t

  def get_user_token(repository, entry_name, user_token \\ nil) do

    {:ok, server} = UserAccountRepository.find_user_account(repository, entry_name)
    case GenServer.call(server, {:verify, user_token_tuple(user_token)}) do
      :invalid -> {:error, :invalid}
      :valid -> {:ok, user_token}
      :expired ->

        {:ok, user_token} = GenServer.call(server, {:create, user_token_tuple(user_token)})
        UserAccountRepository.save_user_token(repository, entry_name)
        {:ok, user_token}
    end
  end


end
