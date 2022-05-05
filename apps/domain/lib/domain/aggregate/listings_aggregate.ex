defmodule M.Domain.Aggregate.ListingsAggregate do
  alias M.Domain.ListingsAggregate.Course
  alias M.Domain.ListingsAggregate.Shop
  alias M.Domain.ListingsAggregate.SKU



  defdelegate create(id, create_at, course_name, course_plan, lessons, use_count \\ 0),
    to: Course

  defdelegate create_sku(id, create_at, name), to: SKU, as: :create

  defdelegate create_shop(id, create_at, name), to: Shop, as: :create

  defdelegate get_sku_list(course), to: Course

  defdelegate get_shop(course, sku), to: Course

  defdelegate add_sku(course, sku, shop), to: Course


end
