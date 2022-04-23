defmodule M.Repo.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :description, :string
    field :name, :string
    field :sku_id, :id
    field :course_plan_id, :id

    belongs_to :sku, M.Repo.SKU,
      define_field: false,
      foreign_key: :sku_id,
      references: :id

    belongs_to :course_plan, M.Repo.Course.Plan,
      define_field: false,
      foreign_key: :course_plan_id,
      references: :id

    has_many :tutorships, M.Repo.Tutorship,
      foreign_key: :course_id,
      references: :id

    has_many :bought_packages, M.Repo.Bought.Package,
      foreign_key: :course_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
