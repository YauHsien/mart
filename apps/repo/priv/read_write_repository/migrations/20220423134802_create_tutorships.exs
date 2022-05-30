defmodule M.Repo.Repo.Migrations.CreateTutorships do
  use Ecto.Migration

  def change do
    create table(:tutorships) do
      add :name, :string
      add :is_owner, :boolean, default: false, null: false
      add :user_account_id, references(:user_accounts, on_delete: :nothing)
      add :shop_id, references(:shops, on_delete: :nothing)
      add :course_id, references(:courses, on_delete: :nothing)

      timestamps()
    end

    create index(:tutorships, [:user_account_id])
    create index(:tutorships, [:shop_id])
  end
end
