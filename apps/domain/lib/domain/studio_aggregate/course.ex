defmodule M.Domain.StudioAggregate.Course do
	alias M.Domain.StudioAggregate.Lesson



  use TypedStruct

  @typedoc """
  Object: Course (Aggregate root)
  Aggregate: Studio
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :name, String.t(), enforce: true
    field :plan, String.t(), enforce: true
    field :use_count, integer()
    field :lessons, Keyword.t(), default: []
  end



  @spec create(integer(), NaiveDateTime.t(), String.t(), String.t(), Strint.t()) :: t()

  @spec create(integer(), NaiveDateTime.t(), String.t(), String.t(), Strint.t(), integer()) :: t()

  def create(id, create_at, course_name, course_plan, lessons, use_count \\ 0) do

    %__MODULE__{
      id: id,
      create_at: create_at,
      name: course_name,
      plan: course_plan,
      lessons: lessons,
      use_count: use_count
    }
  end



  @spec get_plan(t()) :: list()

  def get_plan(course) do

    [course.plan] ++ (
      Keyword.values(course.lessons)
      |> Enum.map(&( {&1.chapter, &1.description} ))
    )
  end



  @spec get_lessons(t()) :: list()

  def get_lessons(course) do

    Keyword.keys(course.lessons)
    |> Enum.map(&( Keyword.get(course.lessons, &1) ))
  end



  @spec add_lesson(t(), integer(), Lesson.t()) :: t()

  def add_lesson(course, chapter, lesson) do

    Keyword.put(course.lessons, chapter, lesson)
  end


end
