defmodule M.Core.MartRepo.HandlingEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "handling_event" do
    field :tutor_id, :id
    field :course_id, :id
    field :description, :string

    belongs_to :turor, M.Core.MartRepo.Tutorship,
      define_field: false,
      foreign_key: :tutor_id,
      references: :id

    belongs_to :course, M.Core.MartRepo.Course,
      define_field: false,
      foreign_key: :course_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(handling_event, attrs) do
    handling_event
    |> cast(attrs, [:tutor_id, :course_id, :description])
    |> validate_required([:tutor_id, :course_id, :description])
  end
end
