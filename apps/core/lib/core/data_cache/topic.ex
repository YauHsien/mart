import YDToolkit



value_object M.Core.DataCache.RequestTopic do

  use TypedStruct
  typedstruct do
    field :name, :string, enforce: true
  end

  @spec create(String.t) :: t()
  def create(name), do: %__MODULE__{name: name}
end



value_object M.Core.DataCache.ReturnTopic do

  use TypedStruct
  typedstruct do
    field :name, :string, enfoce: true
  end

  @spec create(String.t) :: t()
  def create(name), do: %__MODULE__{name: name}
end
