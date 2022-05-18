import YDToolkit

entity M.Domain.Branding.TutorEntity do
  alias M.Domain.ByApp
  alias M.Domain.Branding.TutorEntity

  use TypedStruct
  typedstruct do
    field :field, :string
  end

  #defimpl ByApp.TutorModel do
  #  def create(%TutorEntity{} = entity), do: ByApp.TutorModel.create(entity)
  #end
end
