defmodule M.Repo.ReadWriteRepository.Migrations.Create_UAHandlingEvent do
  use Ecto.Migration

  def change do

    create table(:user_account_handling_events) do
      add :time, :naive_datetime
      add :user_account_id, references(:user_accounts, on_delete: :nothing)
      add :event, :string

      timestamps()
    end

    create index(:user_account_handling_events, [:user_account_id])
  end
end
