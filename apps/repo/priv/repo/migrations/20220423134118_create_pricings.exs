defmodule M.Repo.Repo.Migrations.CreatePricings do
  use Ecto.Migration

  def change do
    create table(:pricings) do
      add :price, :decimal
      add :sku_id, references(:skus, on_delete: :nothing)
      add :promotion_id, references(:promotions, on_delete: :nothing)

      timestamps()
    end

    create index(:pricings, [:sku_id])
    create index(:pricings, [:promotion_id])
  end
end
