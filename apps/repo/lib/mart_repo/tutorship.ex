defmodule M.Repo.Tutorship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tutorships" do
    field :is_owner, :boolean, default: false
    field :name, :string
    field :user_account_id, :id
    field :shop_id, :id
    field :course_id, :id

    many_to_many :rooms, M.Repo.Room,
      join_through: :lecturers

    timestamps()
  end

  @doc false
  def changeset(tutorship, attrs) do
    tutorship
    |> cast(attrs, [:name, :is_owner])
    |> validate_required([:name, :is_owner])
  end
end
