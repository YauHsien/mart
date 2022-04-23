defmodule M.Repo.Repo.Migrations.CreateRoomVlogs do
  use Ecto.Migration

  def change do
    create table(:room_vlogs) do
      add :starting_seconds, :float
      add :ending_seconds, :float
      add :uri, :string
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:room_vlogs, [:room_id])
  end
end
