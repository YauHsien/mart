import YDToolkit
alias M.Domain.Branding
alias Branding.HandlingEventEntity
alias HandlingEventEntity.Protocol

defprotocol Protocol do
  alias Branding.CourseAggregate
  #alias Branding.TutorEntity

  @spec set(HandlingEventEntity, CourseAggregate, TutorEntity, :atom, NaiveDateTime) :: HandlingEventEntity
  def set(obj, course, tutor, case_term, date_time)
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
    field :case, :atom, enforce: true
    field :time, NaiveDateTime, default: NaiveDateTime.utc_now()
  end

  defimpl Protocol do
    def set(%HandlingEventEntity{} = obj, course, tutor, case_term, date_time),
      do: %HandlingEventEntity{obj | course: course, tutor: tutor, case: case_term, time: date_time}
  end
end
