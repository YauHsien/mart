defmodule M.Repo.Bought.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bought_tickets" do
    field :name, :string
    field :bought_package_id, :id
    field :lesson_id, :id

    belongs_to :bought_package, M.Repo.Bought.Package,
      define_field: false,
      foreign_key: :bought_package_id,
      references: :id

    belongs_to :lesson, M.Repo.Lesson,
      define_field: false,
      foreign_key: :lesson_id,
      references: :id

    has_one :studentship, M.Repo.Studentship,
      foreign_key: :bought_ticket_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
