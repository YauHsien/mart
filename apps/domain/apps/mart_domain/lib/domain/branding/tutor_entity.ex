import YDToolkit
alias M.Domain.Branding
alias Branding.TutorEntity
alias TutorEntity.Protocol

defprotocol Protocol do
	#TODO: need impl.
end

entity TutorEntity do

  @type id :: :integer | String.t

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :name, :string, enforce: true
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
