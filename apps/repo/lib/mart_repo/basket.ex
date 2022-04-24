defmodule M.Repo.Basket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "baskets" do
    field :description, :string
    field :user_account_id, :id

    belongs_to :user_account, M.Repo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    has_many :sales_order_items, M.Repo.SalesOrder.Item,
      foreign_key: :basket_id,
      references: :id

    has_one :sales_order, M.Repo.SalesOrder,
      foreign_key: :basket_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(basket, attrs) do
    basket
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
