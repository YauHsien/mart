defmodule M.Repo.Room.Vlog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "room_vlogs" do
    field :ending_seconds, :float
    field :starting_seconds, :float
    field :uri, :string
    field :room_id, :id

    belongs_to :room, M.Repo.Room,
      define_field: false,
      foreign_key: :room_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(vlog, attrs) do
    vlog
    |> cast(attrs, [:starting_seconds, :ending_seconds, :uri])
    |> validate_required([:starting_seconds, :ending_seconds, :uri, :room_id])
  end
end
