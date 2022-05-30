defmodule M.Repo.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :bookkeeping_datetime, :naive_datetime
      add :amount, :decimal
      add :via, :string
      add :arguments, :string
      add :user_account_id, references(:user_accounts, on_delete: :nothing)
      add :sales_order_id, references(:sales_orders, on_delete: :nothing)

      timestamps()
    end

    create index(:payments, [:user_account_id])
    create index(:payments, [:sales_order_id])
  end
end
