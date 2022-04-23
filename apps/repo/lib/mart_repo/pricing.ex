defmodule M.Repo.Pricing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pricings" do
    field :price, :decimal
    field :sku_id, :id
    field :promotion_id, :id

    timestamps()
  end

  @doc false
  def changeset(pricing, attrs) do
    pricing
    |> cast(attrs, [:price])
    |> validate_required([:price])
  end
end
