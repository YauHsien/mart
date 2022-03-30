defmodule M.Member.User.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_accounts" do
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

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:username, :password, :salt, :user_token, :expired_when])
    |> validate_required([:username, :password, :salt])
  end
end
