defmodule M.Domain.Member.UserAccount do
  require M.Domain.Member
  alias M.Domain.Member.UserToken
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
    field :name, M.Domain.Member.username(), enforce: true
    field :password, M.Domain.Member.password(), enforce: true
    field :user_token, M.Domain.Member.user_token(), enforce: true
    field :token_history, M.Domain.Member.user_token_list(), enforce: true
  end



  @spec create(String.t(), String.t()) :: t()

  @spec create(String.t(), String.t(), NaiveDateTime.t()) :: t()

  def create(username, password, datetime \\ NaiveDateTime.utc_now()) do

    salt =
      datetime
      |> NaiveDateTime.to_gregorian_seconds()
      |> elem(1)
      |> Integer.to_string(16)
    enc_pass = Crypto.sign(password, salt, username)

    pac_user = M.Domain.Member.username(username)
    pac_pass = M.Domain.Member.password(enc_pass, salt, datetime)
    pac_token = UserToken.create(
      pac_user,
      pac_pass
    )

    %M.Domain.Member.UserAccount{
      name: pac_user,
      password: pac_pass,
      user_token: pac_token,
      token_history: []
    }
  end



end
