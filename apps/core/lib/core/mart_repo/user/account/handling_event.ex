defmodule M.Core.MartRepo.User.Account.HandlingEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_account_handling_events" do
    field :time, :naive_datetime
    field :user_account_id, :id
    field :event, :string

    belongs_to :user_account, M.Core.MartRepo.User.Account,
      define_field: false,
      foreign_key: :user_account_id,
      references: :id

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [:time, :event, :user_event_id])
    |> validate_required([:time, :event, :user_account_id])
  end
end
