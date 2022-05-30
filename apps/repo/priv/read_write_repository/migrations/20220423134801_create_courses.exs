defmodule M.Repo.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :description, :string
      add :sku_id, references(:skus, on_delete: :nothing)
      add :course_plan_id, references(:course_plans, on_delete: :nothing)

      timestamps()
    end

    create index(:courses, [:course_plan_id])
    create index(:courses, [:sku_id])
  end
end
