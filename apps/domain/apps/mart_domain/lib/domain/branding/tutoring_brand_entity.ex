import YDToolkit
alias M.Domain.Branding
alias Branding.TutoringBrandEntity
alias TutoringBrandEntity.Protocol

defprotocol Protocol do
  alias Branding.CourseAggregate
  alias Branding.TutorEnttiy

  @type sku :: String.t

  @spec get_course(TutoringBrandEntity, sku) :: CourseAggregate
  def get_course(obj, sku)

  @spec get_sku_list(TutoringBrandEntity, CourseAggregate) :: [sku()]
  def get_sku_list(obj, course)

  @spec get_tutors(TutoringBrandEntity, :owner | :partner) :: [TutorEntity]
  def get_tutors(obj, role)

  @spec get_tutor(TutoringBrandEntity, String) :: [TutorEnttiy]
  def get_tutor(obj, username)
end

entity TutoringBrandEntity do
  alias Branding.CourseAggregate
  alias Branding.TutorEntity

  @type id :: :intger | String.t
  @type sku :: String.t

  use TypedStruct
  typedstruct do
    field :id, id(), default: nil
    field :date, NaiveDateTime, enforce: true
    field :name, :string, enforce: true
    field :owners, [{id(), TutorEntity}], default: []
    field :partners, [{id(), TutorEntity}], default: []
    field :sku_course_mapping, [{sku(), CourseAggregate}], default: []
  end

  defimpl Protocol do
    def get_course(%TutoringBrandEntity{} = obj, sku),
      do: obj.sku_course_mapping |> Keyword.fetch!(sku)

    def get_sku_list(%TutoringBrandEntity{} = obj, %CourseAggregate{id: id}),
      do: obj.sku_course_mapping
      |> Enum.filter(fn {_, %CourseAggregate{id: ^id}} -> true; _ -> false end)
      |> Enum.map(fn {sku, %CourseAggregate{}} -> sku end)

    def get_tutors(%TutoringBrandEntity{} = obj, :owner),
      do: obj.owners

    def get_tutors(%TutoringBrandEntity{} = obj, :partner),
      do: obj.partners

    def get_tutor(%TutoringBrandEntity{} = obj, username),
      do: obj.owners + obj.partners
      |> Enum.filter(fn {_, %TutorEntity{name: ^username}} -> true; _ -> false end)
  end
end
