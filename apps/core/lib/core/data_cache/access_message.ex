import YDToolkit



aggregate M.Core.DataCache.AccessMessage do
  alias M.Core.DataCache.ReturnTopic

  use TypedStruct
  typedstruct do
    field :id, term(), enforce: true
    field :message, term(), enforce: true
    field :return_topic, ReturnTopic
  end

  @spec create(term(), ReturnTopic) :: t()
  @spec create(term(), ReturnTopic, term()) :: t()
  def create(message, return_topic, id \\ {__MODULE__, NaiveDateTime.utc_now()}) do
    %__MODULE__{id: id, message: message, return_topic: return_topic}
  end
end
