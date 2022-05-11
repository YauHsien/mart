defmodule M.Domain.Course.CourseAgendaAggregate.CourseAgenda do
  use M.Domain.Stereotype, :aggregate_root

  alias M.Domain.Branding.TutoringBrand
  alias M.Domain.Course.CourseAgendaAggregate.Lesson
  alias M.Domain.Listing.ListingAggregate.Listing
  alias M.Domain.Portfolio.PortfolioAggregate.BoughtPackage

  use TypedStruct
  typedstruct do
    
  end
end
