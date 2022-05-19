import YDToolkit
alias M.Domain.Course
alias M.Domain.Sales
alias M.Domain.ByGroup.CustomerRepository
alias CustomerRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository CustomerRepository do
  alias Course.CustomerAggregate
  alias Sales.CustomerEntity
  @command_channel Application.fetch_env!(:mart_domain, :repo_write_pub_sub)
  @query_channel Application.fetch_env!(:mart_domain, :repo_read_pub_sub)
  @repository Application.fetch_env!(:mart_domain, :repo_for_customer_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
