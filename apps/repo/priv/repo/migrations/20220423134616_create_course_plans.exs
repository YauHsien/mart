defmodule M.Repo.Repo.Migrations.CreateCoursePlans do
  use Ecto.Migration

  def change do
    create table(:course_plans) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
