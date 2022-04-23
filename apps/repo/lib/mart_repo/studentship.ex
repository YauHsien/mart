defmodule M.Repo.Studentship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "studentships" do
    field :comment, :string
    field :comment_time, :naive_datetime
    field :max_stars, :integer
    field :stars, :integer
    field :user_account_id, :id
    field :room_id, :id
    field :bought_ticket_id, :id

    timestamps()
  end

  @doc false
  def changeset(studentship, attrs) do
    studentship
    |> cast(attrs, [:stars, :max_stars, :comment, :comment_time])
    |> validate_required([:stars, :max_stars, :comment, :comment_time])
  end
end
