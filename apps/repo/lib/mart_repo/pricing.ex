defmodule M.Repo.Pricing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pricings" do
    field :price, :decimal
    field :sku_id, :id
    field :promotion_id, :id

    belongs_to :sku, M.Repo.SKU,
      define_field: false,
      foreign_key: :sku_id,
      references: :id

    belongs_to :promotion, M.Repo.Promotion,
      define_field: false,
      foreign_key: :promotion_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(pricing, attrs) do
    pricing
    |> cast(attrs, [:price])
    |> validate_required([:price])
  end
end
