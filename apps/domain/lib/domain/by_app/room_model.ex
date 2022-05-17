defprotocol M.Domain.RoomModel do
  def create(opts)
end

defimpl M.Domain.RoomModel, for: M.Domain.Application.CourseApplication do
  def create(opts), do: M.Domain.Course.RoomAggregate.create(opts)
end
