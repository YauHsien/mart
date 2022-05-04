defmodule M.Domain.ListingsAggregate.Course do
  alias M.Domain.ListingsAggregate.Shop
  alias M.Domain.ListingsAggregate.SKU


  use TypedStruct

  @typedoc """
  Object: Course (Aggregate root)
  Aggregate: Listings
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :name, String.t(), enforce: true
    field :plan, String.t(), enforce: true
    field :lessons, String.t(), enforce: true
    field :use_count, integer()
    field :sku_shops, Keyword.t(), default: []
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



  @spec get_sku_list(t()) :: [SKU.t()]

  def get_sku_list(course),
    do: Keyword.keys(course.sku_shops)



  @spec get_shop(t(), SKU.t()) :: Shop.t() | nil

  def get_shop(course, sku),
    do: Keyword.get(course, sku)



  @spec add_sku(String.t(), SKU.t(), Shop.t()) :: t()

  def add_sku(course, sku, shop) do

    course.sku_shops
    |> Keyword.put(sku, shop)

    course
  end


end
