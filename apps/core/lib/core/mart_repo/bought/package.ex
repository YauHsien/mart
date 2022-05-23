defmodule M.Core.MartRepo.Bought.Package do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bought_packages" do

    field :course_id, :id
    field :sales_order_item_id, :id
    field :user_account_id, :id

    belongs_to :course, M.Core.MartRepo.Course,
      define_field: false,
      foreign_key: :course_id,
      references: :id

    belongs_to :sales_order_item, M.Core.MartRepo.SalesOrder.Item,
      define_field: false,
      foreign_key: :sales_order_item_id,
      references: :id

    belongs_to :user_account, M.Core.MartRepo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    has_many :bought_tickets, M.Core.MartRepo.Bought.Ticket,
      foreign_key: :bought_package_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(package, attrs) do
    package
    |> cast(attrs, [])
    |> validate_required([:course_id, :sales_order_item_id, :user_account_id])
  end
end
