defmodule M.Member.User.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias M.Member.User.Account
  alias M.Member.User.Token
  alias Plug.Crypto
  alias Timex.Timezone

  schema "user_accounts" do
    field :password_changed_when, :naive_datetime
    field :expired_when, :naive_datetime
    field :password, :string
    field :salt, :string
    field :user_token, :string
    field :username, :string

    has_many :user_tokens, M.Member.User.Token,
      foreign_key: :user_account_id,
      references: :id

    timestamps()
  end

  @doc """
  更改使用者欄位

  # 更改密碼

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

  """
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:username, :password, :salt, :password_changed_when, :user_token, :expired_when])
    |> cast_assoc(:user_tokens)
    |> maybe_change_password()
    |> validate_required([:username, :password, :salt, :password_changed_when])
  end

  defp maybe_change_password(changeset) do
    changeset
    |> Changeset.get_change(:password)
    |> maybe_change_password_in(changeset)
  end

  defp maybe_change_password_in(nil, changeset), do: changeset
  defp maybe_change_password_in(password0, changeset) do
    changeset
    |> Changeset.get_field(:salt)
    |> maybe_change_password(password0, in: changeset)
  end

  defp maybe_change_password(nil, _password, in: changeset), do: changeset # 無效資料，不處理。
  defp maybe_change_password(salt, password0, in: changeset) do
    changeset
    |> Changeset.get_field(:username)
    |> maybe_change_password(password0, salt, in: changeset)
  end

  defp maybe_change_password(nil, _password, _salt, in: changeset), do: changeset # 無效資料，不處理。
  defp maybe_change_password(username, password0, salt, in: changeset) do
    password = Crypto.sign(password0, salt, username)
    password_changed_when = DateTime.now!(Timezone.local.full_name)
    changeset
    |> cast(%{password: password, password_changed_when: password_changed_when}, [:password, :password_changed_when])
  end

  @doc """
  verify/2 檢查帳號名稱與密碼匹配。

  iex> alias M.Member.User.Account
  ...> account = %Account { password: "SFMyNTY.g2gDbQAAAAhKb2huIERvZW4GABsUB-F_AWIAAVGA.cM88H94lay0U08xa12_mQk8_CtzYtsxbV5sxmxOd2IY", salt: "salt", username: "John Doe" }
  ...> Account.verify(account, "password")
  {:ok, "John Doe"}
  iex> Account.verify(account, "password0")
  {:error, :invalid}

  """
  @spec verify(%Account{}, password :: String.t()) :: {:ok, username :: String.t()} | {:error, term()}
  def verify(%Account{password: encrypted_password, salt: salt}, password) do
    password
    |> Crypto.verify(salt, encrypted_password)
  end

  @doc """
  verify!/2 檢查帳號名稱與密碼匹配。

  iex> alias M.Member.User.Account
  ...> account = %Account { password: "SFMyNTY.g2gDbQAAAAhKb2huIERvZW4GABsUB-F_AWIAAVGA.cM88H94lay0U08xa12_mQk8_CtzYtsxbV5sxmxOd2IY", salt: "salt", username: "John Doe" }
  ...> Account.verify!(account, "password")
  true
  iex> Account.verify!(account, "password0")
  false

  """
  @spec verify!(%Account{}, password :: String.t()) :: boolean()
  def verify!(%Account{username: username} = account, password) do
    verify(account, password)
    |> then(&(&1 == {:ok,username}))
  end
end
