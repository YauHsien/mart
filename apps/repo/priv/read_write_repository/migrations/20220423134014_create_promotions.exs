defmodule M.Repo.Repo.Migrations.CreatePromotions do
  use Ecto.Migration

  def change do
    create table(:promotions) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
