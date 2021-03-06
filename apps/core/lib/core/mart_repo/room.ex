defmodule M.Core.MartRepo.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string
    field :starting_datetime, :naive_datetime
    field :ending_datetime, :naive_datetime
    field :lesson_id, :id

    many_to_many :tutorships, M.Core.MartRepo.Tutorship,
      join_through: "lecturers"

    has_many :studentships, M.Core.MartRepo.Studentship,
      foreign_key: :room_id,
      references: :id

    belongs_to :lesson, M.Core.MartRepo.Lesson,
      define_field: false,
      foreign_key: :lesson_id,
      references: :id

    has_many :vlogs, M.Core.MartRepo.Room.Vlog,
      foreign_key: :room_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:name, :starting_datetime, :ending_datetime, :lesson_id])
  end
end
