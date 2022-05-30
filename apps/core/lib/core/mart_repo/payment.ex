defmodule M.Core.MartRepo.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :bookkeeping_datetime, :naive_datetime
    field :amount, :decimal
    field :arguments, :string
    field :via, :string
    field :user_account_id, :id
    field :sales_order_id, :id

    belongs_to :user_account, M.Core.MartRepo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    belongs_to :sales_order, M.Core.MartRepo.SalesOrder,
      define_field: false,
      foreign_key: :sales_order_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :via, :arguments])
    |> validate_required([:amount, :via, :arguments, :user_account_id, :sales_order_id])
  end
end
