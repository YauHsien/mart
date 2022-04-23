defmodule M.Repo.Lecturer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lecturers" do

    field :room_id, :id
    field :tutorship_id, :id

    timestamps()
  end

  @doc false
  def changeset(lecturer, attrs) do
    lecturer
    |> cast(attrs, [])
    |> validate_required([])
  end
end
