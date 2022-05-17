defprotocol M.Domain.LecturingSpecificationModel do
  def create(opts)
end

defimpl M.Domain.LecturingSpecificationModel, for: M.Domain.Application.CourseApplication do
  def create(opts), do: M.Domain.Course.LecturingSpecificationValue.create(opts)
end
