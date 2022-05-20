import YDToolkit
alias M.Domain.Course
alias M.Domain.ByGroup.LecturingSpecificationRepository
alias LecturingSpecificationRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository LecturingSpecificationRepository do
  alias Course.LecturingSpecificationValue
  @command_channel Application.fetch_env!(:mart_domain, :repo_write_pub_sub)
  @query_channel Application.fetch_env!(:mart_domain, :repo_read_pub_sub)
  @repository Application.fetch_env!(:mart_domain, :repo_for_lecturing_specification_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
