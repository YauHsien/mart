defmodule M.Repo.SalesOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales_orders" do

    field :basket_id, :id
    field :user_account_id, :id

    belongs_to :user_account, M.Repo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    has_many :sales_order_items, M.Repo.SalesOrder.Item,
      foreign_key: :basket_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(sales_order, attrs) do
    sales_order
    |> cast(attrs, [])
    |> validate_required([:basket_id, :user_account_id])
  end
end
