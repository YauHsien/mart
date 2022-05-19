import YDToolkit
alias M.Domain.Course
alias M.Domain.ByGroup.RoomRepository
alias RoomRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository RoomRepository do
  alias Course.RoomAggregate
  @command_channel Application.fetch_env!(:mart_domain, :repo_write_pub_sub)
  @query_channel Application.fetch_env!(:mart_domain, :repo_read_pub_sub)
  @repository Application.fetch_env!(:mart_domain, :repo_for_room_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
