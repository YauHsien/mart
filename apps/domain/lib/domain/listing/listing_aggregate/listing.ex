defmodule M.Domain.Listing.ListingAggregate.Listing do
  use M.Domain.Stereotype, :aggregate_root

  alias M.Domain.Course.CourseAgendaAggregate.CourseAgenda
  alias M.Domain.Listing.ListingAggregate.ListingHistory

  use TypedStruct
  typedstruct do
    
  end
end
