defmodule M.Repo.Repo.Migrations.CreateBoughtTickets do
  use Ecto.Migration

  def change do
    create table(:bought_tickets) do
      add :name, :string
      add :bought_package_id, references(:bought_packages, on_delete: :nothing)
      add :lesson_id, references(:lessons, on_delete: :nothing)

      timestamps()
    end

    create index(:bought_tickets, [:bought_package_id])
    create index(:bought_tickets, [:lesson_id])
  end
end
