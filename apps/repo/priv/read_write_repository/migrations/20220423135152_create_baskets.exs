defmodule M.Repo.Repo.Migrations.CreateBaskets do
  use Ecto.Migration

  def change do
    create table(:baskets) do
      add :description, :string
      add :user_account_id, references(:user_accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:baskets, [:user_account_id])
  end
end
