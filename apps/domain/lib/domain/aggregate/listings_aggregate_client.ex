defmodule M.Domain.Aggregate.ListingsAggregateClient do
  import M.Domain.Aggregate.ListingsAggregate.Course
	import M.Domain.Aggregate.ListingsAggregateClient.Macro

  @type id :: integer | String.t

  @spec get(GenServer.t()) :: Course.t()

  def get(aggregate),
    do: GenServer.call(aggregate, query_all())

  @spec get(
    GenServer.t(),
    id()
    :course | :listing | :shop,
    field :: atom()
  ) :: term() | nil

  def get(aggregate, eid, :course, field),
    do: GenServer.call(aggregate, query_course(eid, field))

  def get(aggregate, eid, :listing, field),
    do: GenServer.call(aggregate, query_listing(eid, field))

  def get(aggregate, eid, :shop, field),
    do: GenServer.call(aggregate, query_shop(eid, field))
end
