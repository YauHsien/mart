defmodule M.Repo.Repo.Migrations.CreateLecturers do
  use Ecto.Migration

  def change do
    create table(:lecturers) do
      add :room_id, references(:rooms, on_delete: :nothing)
      add :tutorship_id, references(:tutorships, on_delete: :nothing)

      timestamps()
    end

    create index(:lecturers, [:room_id])
    create index(:lecturers, [:tutorship_id])
  end
end
