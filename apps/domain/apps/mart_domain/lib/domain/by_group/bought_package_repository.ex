import YDToolkit
alias M.Domain.Course
alias M.Domain.Portfoio
alias M.Domain.ByGroup.BoughtPackageRepository
alias BoughtPackageRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository BoughtPackageRepository do
  alias Course.BoughtPackageEntity
  alias Portfolio.BoughtPackageAggregate
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_bought_package_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
