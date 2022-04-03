defmodule M.Member.Repo.Migrations.AddUniqueKeyToUserAccounts do
  use Ecto.Migration

  def change do
    create unique_index(:user_accounts, ["(lower(username))"], name: :uk_username)
  end
end
