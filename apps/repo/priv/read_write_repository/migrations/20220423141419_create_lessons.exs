defmodule M.Repo.Repo.Migrations.CreateLessons do
  use Ecto.Migration

  def change do
    create table(:lessons) do
      add :name, :string
      add :description, :string
      add :cource_id, references(:courses, on_delete: :nothing)

      timestamps()
    end

    create index(:lessons, [:cource_id])
  end
end
