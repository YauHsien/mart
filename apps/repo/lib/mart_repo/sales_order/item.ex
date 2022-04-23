defmodule M.Repo.SalesOrder.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales_order_items" do

    field :sku_id, :id
    field :basket_id, :id
    field :sales_order_id, :id

    belongs_to :sku, M.Repo.SKU,
      define_field: false,
      foreign_key: :sku_id,
      references: :id

    belongs_to :basket, M.Repo.Basket,
      define_field: false,
      foreign_key: :basket_id,
      references: :id

    belongs_to :sales_order, M.Repo.SalesOrder,
      define_field: false,
      foreign_key: :sales_order_id,
      references: :id

    has_one :bought_package, M.Repo.Bought.Package,
      foreign_key: :sales_order_item_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
