defmodule M.Member.Repo.Migrations.AddFieldPasswordChangedWhenToUserAccounts do
  use Ecto.Migration

  def change do
    alter table(:user_accounts) do
      add :password_changed_when, :naive_datetime
    end
  end
end
