defmodule M.Repo.Repo.Migrations.CreateBoughtPackages do
  use Ecto.Migration

  def change do
    create table(:bought_packages) do
      add :course_id, references(:courses, on_delete: :nothing)
      add :sales_order_item_id, references(:sales_order_items, on_delete: :nothing)
      add :user_account_id, references(:user_accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:bought_packages, [:course_id])
    create index(:bought_packages, [:sales_order_item_id])
    create index(:bought_packages, [:user_account_id])
  end
end
