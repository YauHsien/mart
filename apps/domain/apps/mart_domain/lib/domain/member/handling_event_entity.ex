import YDToolkit
alias M.Domain.Member
alias Member.HandlingEventEntity
alias HandlingEventEntity.Protocol

defprotocol Protocol do
	#TODO: need impl.
end

entity HandlingEventEntity do

  use TypedStruct
  @typedoc """
  Object: HandlingEventEntity
  Domain: Member
  """
  typedstruct do
    field :id, :integer, default: nil
    field :time, NaiveDateTime.t, default: nil
    field :user_account_id, :integer, enforce: true
    field :event, :term, enforce: true
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
