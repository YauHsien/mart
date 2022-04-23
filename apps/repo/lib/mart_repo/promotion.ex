defmodule M.Repo.Promotion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promotions" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(promotion, attrs) do
    promotion
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
