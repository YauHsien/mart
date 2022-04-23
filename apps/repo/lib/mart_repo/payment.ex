defmodule M.Repo.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :decimal
    field :arguments, :string
    field :via, :string
    field :user_account_id, :id
    field :sales_order_id, :id

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :via, :arguments])
    |> validate_required([:amount, :via, :arguments])
  end
end
