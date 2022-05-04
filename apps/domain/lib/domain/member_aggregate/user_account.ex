defmodule M.Domain.MemberAggregate.UserAccount do
  require M.Domain.MemberAggregate
  alias   M.Domain.MemberAggregate
  alias   M.Domain.MemberAggregate.UserToken
  alias Plug.Crypto



  use TypedStruct

  @typedoc """
  Object: UserAccount (Aggregate root)
  Aggregate: Member
  """
  typedstruct do
    field :id, integer(), default: nil
    field :inserted_at, NaiveDateTime.t()
    field :updated_at, NaiveDateTime.t()
    field :name, MemberAggregate.username(), enforce: true
    field :password, MemberAggregate.password(), enforce: true
    field :user_token, MemberAggregate.user_token(), enforce: true
    field :token_history, MemberAggregate.user_token_list(), enforce: true
  end



  @spec create(String.t(), String.t()) :: t()

  @spec create(String.t(), String.t(), NaiveDateTime.t()) :: t()

  def create(username, password, datetime \\ NaiveDateTime.utc_now()) do

    pac_name = MemberAggregate.username(username)
    pac_pass = create_password(username, password, datetime)
    pac_token = UserToken.create(pac_name, pac_pass)

    %__MODULE__{
      name: pac_name,
      password: pac_pass,
      user_token: pac_token,
      token_history: []
    }
  end



  @spec set_password(t(), String.t()) :: t()

  @spec set_password(t(), String.t(), NaiveDateTime.t()) :: t()

  def set_password(user_account, password, datetime \\ NaiveDateTime.utc_now()) do

    MemberAggregate.username(username) = user_account.name
    pac_pass = create_password(username, password, datetime)

    %__MODULE__{ user_account | password: pac_pass }
  end



  defp create_password(username, password, datetime) do

    salt =
      datetime
      |> NaiveDateTime.to_gregorian_seconds()
      |> elem(1)
      |> Integer.to_string(16)
    enc_pass = Crypto.sign(password, salt, username)

    MemberAggregate.password(enc_pass, salt, datetime)
  end



  @spec verify_password(t(), String.t()) :: :ok | :invalid

  def verify_password(user_account, plain_password) do

    MemberAggregate.username(username) = user_account.name
    MemberAggregate.password(enc_pass, salt, _) = user_account.password

    case Crypto.verify(plain_password, salt, enc_pass) do
      term when term == {:ok, username} or term == {:error, :expired} ->
        :ok
      {:error, :invalid} ->
        :invalid
    end
  end



  @spec new_token(t(), NaiveDateTime.t()) :: t()

  def new_token(user_account, expired_when \\ nil) do

    %__MODULE__{
      user_account |
      user_token: UserToken.create(user_account.name, user_account.password, expired_when),
      token_history: [ user_account.user_token | user_account.token_history ]
    }
  end



  @spec renew_token(t(), String.t()) :: t() | :invalid

  def renew_token(user_account, plain_token, expired_when \\ nil) do

    MemberAggregate.username(username) = user_account.name
    MemberAggregate.password(enc_pass, salt, _) = user_account.password

    case Crypto.verify(plain_token, salt, enc_pass) do

      term when term == {:ok, username} or term == {:error, :expired} ->
        new_token(user_account, expired_when)

      {:error, :invalid} ->
        :invalid

    end
  end



  @spec verify_token(t(), String.t()) :: :ok | :expired | :invalid

  def verify_token(user_account, plain_token) do

    MemberAggregate.username(username) = user_account.name
    MemberAggregate.password(enc_pass, salt, _) = user_account.password

    case Crypto.verify(plain_token, salt, enc_pass) do
      {:ok, ^username} ->
        :ok
      {:error, :expired} ->
        :expired
      {:error, :invalid} ->
        :invalid
    end
  end


end
