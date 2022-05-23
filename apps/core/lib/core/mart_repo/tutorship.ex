defmodule M.Core.MartRepo.Tutorship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tutorships" do
    field :is_owner, :boolean, default: false
    field :name, :string
    field :user_account_id, :id
    field :shop_id, :id
    field :course_id, :id

    many_to_many :rooms, M.Core.MartRepo.Room,
      join_through: "lectures"

    belongs_to :shop, M.Core.MartRepo.Shop,
      define_field: false,
      foreign_key: :shop_id,
      references: :id

    belongs_to :course, M.Core.MartRepo.Course,
      define_field: false,
      foreign_key: :course_id,
      references: :id

    belongs_to :user_account, M.Core.MartRepo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(tutorship, attrs) do
    tutorship
    |> cast(attrs, [:name, :is_owner])
    |> validate_required([:name, :is_owner, :user_account_id, :shop_id, :course_id])
  end
end
