defmodule M.Repo.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :starting_datetime, :naive_datetime
      add :ending_datetime, :naive_datetime
      add :lesson_id, references(:lessons, on_delete: :nothing)

      timestamps()
    end

    create index(:rooms, [:lesson_id])
  end
end
