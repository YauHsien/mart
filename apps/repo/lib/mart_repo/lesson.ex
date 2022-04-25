defmodule M.Repo.Lesson do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lessons" do
    field :description, :string
    field :name, :string
    field :cource_id, :id

    belongs_to :course, M.Repo.Course,
      define_field: false,
      foreign_key: :course_id,
      references: :id

    belongs_to :room, M.Repo.Room,
      define_field: false,
      foreign_key: :room_id,
      references: :id

    has_many :bought_tickets, M.Repo.Bought.Ticket,
      foreign_key: :lesson_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(lesson, attrs) do
    lesson
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description, :course_id])
  end
end
