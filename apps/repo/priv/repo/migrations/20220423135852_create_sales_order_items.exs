defmodule M.Repo.Repo.Migrations.CreateSalesOrderItems do
  use Ecto.Migration

  def change do
    create table(:sales_order_items) do
      add :sku_id, references(:skus, on_delete: :nothing)
      add :basket_id, references(:baskets, on_delete: :nothing)
      add :sales_order_id, references(:sales_orders, on_delete: :nothing)

      timestamps()
    end

    create index(:sales_order_items, [:sku_id])
    create index(:sales_order_items, [:basket_id])
    create index(:sales_order_items, [:sales_order_id])
  end
end
