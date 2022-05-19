import YDToolkit
alias M.Domain.Branding
alias Branding.HandlingEventEntity
alias HandlingEventEntity.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

entity HandlingEventEntity do
  alias Branding.CourseAggregate
  alias Branding.TutorEntity

  @type id :: :integer | String.t

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :course, CourseAggregate, enforce: true
    field :tutor, TutorEntity, enforce: true
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
