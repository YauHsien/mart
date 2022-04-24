defmodule M.Repo.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string
    field :starting_datetime, :naive_datetime
    field :ending_datetime, :naive_datetime

    many_to_many :tutorships, M.Repo.Tutorship,
      join_through: "lecturers"

    has_many :studentships, M.Repo.Studentship,
      foreign_key: :room_id,
      references: :id

    has_one :lesson, M.Repo.Lesson,
      foreign_key: :room_id,
      references: :id

    has_many :vlogs, M.Repo.Room.Vlog,
      foreign_key: :room_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
