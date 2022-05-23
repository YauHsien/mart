defmodule M.Core.MartRepo.SalesOrder.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales_order_items" do

    field :sku_id, :id
    field :basket_id, :id
    field :sales_order_id, :id

    belongs_to :sku, M.Core.MartRepo.SKU,
      define_field: false,
      foreign_key: :sku_id,
      references: :id

    belongs_to :basket, M.Core.MartRepo.Basket,
      define_field: false,
      foreign_key: :basket_id,
      references: :id

    belongs_to :sales_order, M.Core.MartRepo.SalesOrder,
      define_field: false,
      foreign_key: :sales_order_id,
      references: :id

    has_one :bought_package, M.Core.MartRepo.Bought.Package,
      foreign_key: :sales_order_item_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [])
    |> validate_required([:sku_id, :sales_order_id])
  end
end
