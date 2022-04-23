defmodule M.Repo.Repo.Migrations.CreateStudentships do
  use Ecto.Migration

  def change do
    create table(:studentships) do
      add :stars, :integer
      add :max_stars, :integer
      add :comment, :string
      add :comment_time, :naive_datetime
      add :user_account_id, references(:user_accounts, on_delete: :nothing)
      add :room_id, references(:rooms, on_delete: :nothing)
      add :bought_ticket_id, references(:bought_tickets, on_delete: :nothing)

      timestamps()
    end

    create index(:studentships, [:user_account_id])
    create index(:studentships, [:room_id])
    create index(:studentships, [:bought_ticket_id])
  end
end
