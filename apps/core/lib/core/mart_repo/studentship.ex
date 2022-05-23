defmodule M.Core.MartRepo.Studentship do
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

    belongs_to :room, M.Core.MartRepo.Room,
      define_field: false,
      foreign_key: :room_id,
      references: :id

    belongs_to :bought_ticket, M.Core.MartRepo.Bought.Ticket,
      define_field: false,
      foreign_key: :bought_ticket_id,
      references: :id

    belongs_to :user_account, M.Core.MartRepo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(studentship, attrs) do
    studentship
    |> cast(attrs, [:stars, :max_stars, :comment, :comment_time])
    |> validate_required([:stars, :max_stars, :comment, :comment_time, :user_account_id, :room_id, :bought_ticket_id])
  end
end
