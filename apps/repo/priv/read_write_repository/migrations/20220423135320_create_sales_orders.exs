defmodule M.Repo.Repo.Migrations.CreateSalesOrders do
  use Ecto.Migration

  def change do
    create table(:sales_orders) do
      add :basket_id, references(:baskets, on_delete: :nothing)
      add :user_account_id, references(:user_accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:sales_orders, [:basket_id])
    create index(:sales_orders, [:user_account_id])
  end
end
