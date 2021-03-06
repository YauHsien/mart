defmodule M.Core.MartRepo.User.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias M.Core.MartRepo
  alias M.Core.Timespan
  alias MartRepo.User.Account, as: UserAccount
  alias UserAccount.Password
  alias Plug.Crypto

  @derive {Jason.Encoder, only: [:username, :salt, :password_changed_when, :user_token, :expired_when]}
  schema "user_accounts" do
    field :password_changed_when, :naive_datetime
    field :expired_when, :naive_datetime
    field :password, :string
    field :salt, :string
    field :user_token, :string
    field :username, :string

    has_many :user_tokens, M.Core.MartRepo.User.Token,
      foreign_key: :user_account_id,
      references: :id

    has_many :tutorships, M.Core.MartRepo.Tutorship,
      foreign_key: :user_account_id,
      references: :id

    timestamps()
  end

  @doc """
  更改使用者欄位

  - :username
  - :password
  - :salt
  - (:password_changed_when)
  - :user_token
  - (:expired_when)

  # 更改密碼，並變更 session 期限

  iex> alias M.Member.User.Account
  ...> alias Ecto.Changeset
  ...> alias Plug.Crypto
  ...> account = %Account{username: "John Doe"}
  ...> changeset = account |> Account.changeset(%{password: "password", salt: "salt"})
  ...> encrypted_password = changeset |> Changeset.get_change(:password)
  ...> Crypto.verify("password", "salt", encrypted_password)
  {:ok, "John Doe"}
  iex> Crypto.verify("password0", "salt", encrypted_password)
  {:error, :invalid}
  iex> nil == Changeset.get_change(changeset, :password_changed_when)
  false
  iex> nil == Changeset.get_change(changeset, :expired_when)
  false

  """
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:username, :password, :salt, :password_changed_when, :user_token, :expired_when])
    |> cast_assoc(:user_tokens)
    |> Password.maybe_change_password()
    |> reset_expiring_time()
    |> validate_required([:username, :password, :salt, :password_changed_when])
    |> unique_constraint(:username, name: :uk_username)
  end

  @spec reset_expiring_time(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp reset_expiring_time(changeset) do
    expired_when =
      Timespan.to_datetime(after: Application.fetch_env!(:mart_member,:session_timespan))
    changeset
    |> cast(%{expired_when: expired_when}, [:expired_when])
  end

  @doc """
  verify/2 檢查帳號名稱與密碼匹配。

  iex> alias M.Member.User.Account
  ...> alias Plug.Crypto
  ...> account = %Account { password: Crypto.sign("password","salt","John Doe"), salt: "salt", username: "John Doe" }
  ...> Account.verify(account, "password")
  {:ok, "John Doe"}
  iex> Account.verify(account, "password0")
  {:error, :invalid}

  """
  @spec verify(%UserAccount{}, password :: String.t()) :: {:ok, username :: String.t()} | {:error, term()}
  def verify(%UserAccount{password: encrypted_password, salt: salt}, password) do
    password
    |> Crypto.verify(salt, encrypted_password)
  end

  @doc """
  verify!/2 檢查帳號名稱與密碼匹配。

  iex> alias M.Member.User.Account
  ...> alias Plug.Crypto
  ...> account = %Account { password: Crypto.sign("password","salt","John Doe"), salt: "salt", username: "John Doe" }
  ...> Account.verify!(account, "password")
  true
  iex> Account.verify!(account, "password0")
  false

  """
  @spec verify!(%UserAccount{}, password :: String.t()) :: boolean()
  def verify!(%UserAccount{username: _username} = account, password) do
    verify(account, password)
    |> then(&(&1 !== {:error,:invalid}))
  end
end
