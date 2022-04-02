defmodule M.Member.Repo.Migrations.AddUniqueKeyToUserAccounts do
  use Ecto.Migration

  def change do
    create unique_index(:user_accounts, :username, name: :uk_username)
  end
end
