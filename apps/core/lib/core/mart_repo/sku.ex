defmodule M.Core.MartRepo.SKU do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skus" do
    field :name, :string
    field :price, :decimal
    field :shop_id, :id

    belongs_to :shop, M.Core.MartRepo.Shop,
      define_field: false,
      foreign_key: :shop_id,
      references: :id

    has_many :pricings, M.Core.MartRepo.Pricing,
      foreign_key: :sku_id,
      references: :id

    has_one :course, M.Core.MartRepo.Course,
      foreign_key: :sku_id,
      references: :id

    has_many :sales_order_items, M.Core.MartRepo.SalesOrder.Item,
      foreign_key: :sku_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(sku, attrs) do
    sku
    |> cast(attrs, [:name, :price])
    |> validate_required([:name, :price, :shop_id])
  end
end
