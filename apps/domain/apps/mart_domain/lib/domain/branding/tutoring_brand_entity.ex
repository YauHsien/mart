import YDToolkit
alias M.Domain.Branding
alias Branding.TutoringBrandEntity
alias TutoringBrandEntity.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

entity TutoringBrandEntity do
  alias Branding.CourseAggregate
  alias Branding.TutorEntity

  @type id :: :intger | String.t

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :date, NaiveDateTime, enforce: true
    field :name, :string, enforce: true
    field :owners, [{id(), TutorEntity}], default: []
    field :partners, [{id(), TutorEntity}], default: []
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
