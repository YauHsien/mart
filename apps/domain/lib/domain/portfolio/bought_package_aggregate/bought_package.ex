defmodule M.Domain.Portfolio.BoughtPackageAggregate.BoughtPackage do
  use M.Domain.Stereotype, :aggregate_root

  alias M.Domain.Course.CourseAgendaAggregate.CourseAgenda
  alias M.Domain.Customer
  alias M.Domain.Portfolio.PortfolioAggregate.CourseTicket

  use TypedStruct
  typedstruct do
    
  end
end
