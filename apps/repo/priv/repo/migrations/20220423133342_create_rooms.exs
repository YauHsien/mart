defmodule M.Repo.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :starting_datetime, :naive_datetime
      add :ending_datetime, :naive_datetime

      timestamps()
    end
  end
end
