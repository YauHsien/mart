defmodule M.Domain.HandlingEvent do
  use M.Domain.Stereotype, :entity

  alias M.Domain.Branding.TutorAggregate.Tutor
  alias M.Domain.Course.RoomAggregate.Room
  alias M.Domain.Listing.ListingAggregate.Listing
  alias M.Domain.MemberAggregate.UserAccount
  alias M.Domain.Portfolio.PortfolioAggregate.BoughtPackage
  alias M.Domain.Sales.SalesOrderAggregate.SalesOrder

  use TypedStruct
  typedstruct do
    
  end
end
