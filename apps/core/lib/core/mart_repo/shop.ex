defmodule M.Core.MartRepo.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :name, :string

    has_many :tutorships, M.Core.MartRepo.Tutorship,
      foreign_key: :shop_id,
      references: :id

    has_many :skus, M.Core.MartRepo.SKU,
      foreign_key: :shop_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
