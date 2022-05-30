defmodule M.Repo.Repo.Migrations.CreateSkus do
  use Ecto.Migration

  def change do
    create table(:skus) do
      add :name, :string
      add :price, :decimal
      add :shop_id, references(:shops, on_delete: :nothing)

      timestamps()
    end

    create index(:skus, [:shop_id])
  end
end
