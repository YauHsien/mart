defmodule M.Member.User.Token do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:user_token, :expired_when]}
  schema "user_tokens" do
    field :expired_when, :naive_datetime
    field :user_token, :string
    field :user_account_id, :id

    belongs_to :user_account, M.Member.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:user_token, :expired_when])
    |> validate_required([:user_token, :expired_when])
  end
end
