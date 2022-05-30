import YDToolkit
alias M.Core.MartRepo
alias M.Domain.Member
alias MartRepo.User.Account, as: UserAccount
alias Member.UserAccountAggregate
alias Member.PasswordValue
alias Member.UserTokenValue
alias Member.HandlingEventEntity
alias UserAccountAggregate.Protocol

defprotocol Protocol do

  @spec create(String.t, String.t) :: UserAccountAggregate.t
  def create(username, password)

  @spec transfer_from(UserAccount.t, list) :: UserAccountAggregate.t
  def transfer_from(user, using_history)
	#TODO: need impl.

  @doc """
  Support `create/2` and `new/2` operations to build a new user.
  """
  @spec new(UserAccountAggregate.t, UserAccountRepository.t) :: UserAccountAggregate.t
  def new(user, repo)
end

value_object PasswordValue do

  use TypedStruct
  @typedoc """
  Object: PasswordValue
  Domain: Member
  """
  typedstruct do
    field :salt, :term, enforce: true
    field :enc_pass, :string, enforce: true
    field :last_changed, NaiveDateTime.t, enforce: true
  end
end

value_object UserTokenValue do

  use TypedStruct
  @typedoc """
  Object: UserTokenValue
  Domain: Member
  """
  typedstruct do
    field :salt, :term, enforce: true
    field :enc_token, :string, enforce: true
    field :expired_when, NaiveDateTime.t, enforce: true
  end
end

aggregate UserAccountAggregate do

  use TypedStruct
  @typedoc """
  Object: UserAccountAggregate (aggregate root)
  Domain: Member
  """
  typedstruct do
    field :id, :integer, default: nil
    field :name, :string, enforce: true
    field :password, PasswordValue.t, enforce: true
    field :user_token, UserTokenValue.t, enforce: true
    field :using_history, [HandlingEventEntity.t], default: []
  end

  defimpl Protocol do

    @spec create(String.t, String.t) :: UserAccountAggregate.t
    @doc """
    Create a `UserAccountAggregate` by `username` and `password`.
    """
    def create(username, password) do
      datetime = NaiveDateTime.utc_now()
      {:password, enc_pass, salt, changed_when} = pac_pass =
        UserAccountAggregate.create_password(username, password, datetime)
      {:user_token, enc_token, expired_when} =
        UserAccountAggregate.create_token(username, enc_pass, salt)
      %UserAccountAggregate{
        name: username,
        password: %PasswordValue {
          salt: salt,
          enc_pass: enc_pass,
          last_changed: changed_when
        },
        user_token: %UserTokenValue {
          salt: salt,
          enc_token: enc_token,
          expired_when: expired_when
        }
      }
    end

    @spec transfer_from(UserAccount.t, list) :: UserAccountAggregate.t
    def transfer_from(user, using_history) do
      %UserAccountAggregate{
        id: user.id,
        name: user.name,
        password:
        %PasswordValue{salt: user.salt, enc_pass: user.password,
                       last_changed: user.password_changed_when},
        user_token:
        %UserTokenValue{salt: user.salt, enc_token: user.user_token,
                        expired_when: user.expired_when},
        using_history: using_history
      }
    end
    #TODO: need impl.
  end

  alias Plug.Crypto
  @max_age 86400

  defmacro username_tuple(name), do: quote do: {:username, unquote(name)}

  defmacro password_triple(password, salt, changed_when),
    do: quote do: {:password, unquote(password), unquote(salt), unquote(changed_when)}

  defmacro user_token_tuple(user_token, expired_when),
    do: quote do: {:user_token, unquote(user_token), unquote(expired_when)}

  @spec create_password(username :: String.t, password :: String.t, datetime :: NaiveDateTime.t)
  :: {:password, enc_pass :: String.t, salt :: String.t, datetime :: NaiveDateTime.t}
  def create_password(username, password, datetime) do

    salt =
      datetime
      |> NaiveDateTime.to_gregorian_seconds()
      |> elem(1)
      |> Integer.to_string(16)
    enc_pass = Crypto.sign(password, salt, username)

    password_triple(enc_pass, salt, datetime)
  end

  @spec create_token(username :: String.t, enc_pass :: String.t, salt :: String.t, max_age :: integer)
  :: {:user_token, token :: String.t, NaiveDateTime.t}
  def create_token(username, enc_pass, salt, max_age \\ @max_age) do
    Crypto.sign(enc_pass, salt, username, max_age: max_age)
    |> user_token_tuple(after_max_age(NaiveDateTime.utc_now(), max_age))
  end

  defp after_max_age(datetime, max_age) do
    NaiveDateTime.add(datetime, max_age)
  end
end
