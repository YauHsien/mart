defmodule M.Member.Repo.Migrations.CreateUserTokens do
  use Ecto.Migration

  def change do
    create table(:user_tokens) do
      add :user_token, :string
      add :expired_when, :naive_datetime
      add :user_account_id, references(:user_accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:user_tokens, [:user_account_id])
  end
end
