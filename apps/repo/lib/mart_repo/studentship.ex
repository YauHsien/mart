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

    belongs_to :room, M.Repo.Room,
      define_field: false,
      foreign_key: :room_id,
      references: :id

    belongs_to :bought_ticket, M.Repo.Bought.Ticket,
      define_field: false,
      foreign_key: :bought_ticket_id,
      references: :id

    belongs_to :user_account, M.Repo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(studentship, attrs) do
    studentship
    |> cast(attrs, [:stars, :max_stars, :comment, :comment_time])
    |> validate_required([:stars, :max_stars, :comment, :comment_time])
  end
end
