defmodule M.Member.Repo.Migrations.CreateUserAccounts do
  use Ecto.Migration

  def change do
    create table(:user_accounts) do
      add :username, :string
      add :password, :string
      add :salt, :string
      add :user_token, :string
      add :expired_when, :naive_datetime

      timestamps()
    end
  end
end
