defmodule M.Repo.Bought.Package do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bought_packages" do

    field :course_id, :id
    field :sales_order_item_id, :id
    field :user_account_id, :id

    belongs_to :course, M.Repo.Course,
      define_field: false,
      foreign_key: :course_id,
      references: :id

    belongs_to :sales_order_item, M.Repo.SalesOrder.Item,
      define_field: false,
      foreign_key: :sales_order_item_id,
      references: :id

    belongs_to :user_account, M.Repo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    has_many :bought_tickets, M.Repo.Bought.Ticket,
      foreign_key: :bought_package_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(package, attrs) do
    package
    |> cast(attrs, [])
    |> validate_required([])
  end
end
