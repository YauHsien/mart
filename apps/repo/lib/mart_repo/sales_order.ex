defmodule M.Repo.SalesOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales_orders" do

    field :basket_id, :id
    field :user_account_id, :id

    timestamps()
  end

  @doc false
  def changeset(sales_order, attrs) do
    sales_order
    |> cast(attrs, [])
    |> validate_required([])
  end
end
