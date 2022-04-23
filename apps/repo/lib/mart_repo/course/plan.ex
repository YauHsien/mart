defmodule M.Repo.Course.Plan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "course_plans" do
    field :description, :string
    field :name, :string

    has_many :courses, M.Repo.Course,
      foreign_key: :course_plan_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
