defmodule M.Repo.SKU do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skus" do
    field :name, :string
    field :price, :decimal
    field :shop_id, :id

    timestamps()
  end

  @doc false
  def changeset(sku, attrs) do
    sku
    |> cast(attrs, [:name, :price])
    |> validate_required([:name, :price])
  end
end
