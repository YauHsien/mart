defmodule M.Domain.StudioAggregate do
  alias M.Domain.StudioAggregate.Course
  alias M.Domain.StudioAggregate.Lesson



  defdelegate create(id, create_at, course_name, course_plan, use_count \\ 0),
    to: Course

  defdelegate create_lesson(id, create_at, chapter, description),
    to: Lesson, as: :create

  defdelegate get_plan(course), to: Course

  defdelegate get_lessons(course), to: Course

  @spec get_lesson(Course.t(), integer) :: Lesson.t()
  def get_lesson(course, chapter) do
    Keyword.get(course.lessons, chapter)
  end

  defdelegate add_lesson(course, chapter, lesson), to: Course

end
