defmodule M.Domain.StudioAggregate.Lesson do



  use TypedStruct

  @typedoc """
  Object: Lesson
  Aggregate: Studio
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :chapter, integer(), enforce: true
    field :description, String.t(), enforce: true
  end



  @spec create(integer(), NaiveDateTime.t(), integer(), String.t()) :: t()

  def create(id, create_at, chapter, description) do

    %__MODULE__{
      id: id,
      create_at: create_at,
      chapter: chapter,
      description: description
    }
  end


end
