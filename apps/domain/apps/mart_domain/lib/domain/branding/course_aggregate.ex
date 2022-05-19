import YDToolkit
alias M.Domain.Branding
alias Branding.CourseAggregate
alias CourseAggregate.AgendaValue
alias CourseAggregate.HandlingHistoryEntity
alias CourseAggregate.LessonValue
alias CourseAggregate.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

aggregate CourseAggregate do
  alias Branding.TutoringBrandEntity

  @type id :: :integer | String.t

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :name, :string, enforce: true
    field :agenda, AgendaValue, enforce: true
    field :handling_history, HandlingHistoryEntity, enforce: true
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end

value_object AgendaValue do
  alias Branding.LessonValue

  @type id :: :integer | String.t

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :content, :string
    field :lessons_mapping, [{id(), Lesson}]
  end
end

value_object Lesson do

  @type id :: :integer | String.t
  @type duration_unit :: :atom

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :name, :string, enforce: true
    field :duration, {duration_unit(), :integer}, default: nil
    field :specification, :string, enforce: true
    field :goal, :string, enforce: true
  end
end

entity HandlingHistoryEntity do
  alias Branding.HandlingEventEntity

  @type id :: :integer | String.t

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :handling_events, [HandlingEventEntity], default: []
  end
end
