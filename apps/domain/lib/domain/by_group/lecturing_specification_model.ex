alias M.Domain.ByGroup.LecturingSpecificationModel
alias M.Domain.Course.LecturingSpecificationValue

defprotocol LecturingSpecificationModel do
  def create(opts)
end

defimpl LecturingSpecificationModel, for: M.Domain.Application.CourseApplication do
  def create(opts), do: LecturingSpecificationValue.create(opts)
end
