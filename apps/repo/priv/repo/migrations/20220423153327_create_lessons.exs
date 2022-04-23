defmodule M.Repo.Repo.Migrations.CreateLessons do
  use Ecto.Migration

  def change do
    create table(:lessons) do
      add :name, :string
      add :description, :string
      add :cource_id, references(:courses, on_delete: :nothing)
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:lessons, [:cource_id])
    create index(:lessons, [:room_id])
  end
end
