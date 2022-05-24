alias M.Core.DataCache
alias DataCache.AccessMessage
alias DataCache.BrandingTutorAccessMessage
alias DataCache.BrandingTutoringBrandAccessMessage
alias DataCache.BrandingCourseAccessMessage
alias DataCache.BrandingHandlingEventAccessMessage
#alias DataCache.CourseAccessMessage
#alias DataCache.ListingAccessMessage
#alias DataCache.PortfolioAccessMessage
#alias DataCache.SalesAccessMessage

defmodule AccessMessage do
  @range [
    {:branding, :entity, :tutor},
    {:branding, :entity, :tutoring_brand},
    {:branding, :aggregate, :course},
    {:branding, :entity, :handling_event},
    #TODO: complete other domain objects in domains :portfolio, :course, :listing, and :sales
  ]
  defmacro __using__(domain: domain, type: type, name: name) when {domain, type, name} in @range do
    quote do
      alias M.Core.DataCache.ReturnTopic

      use TypedStruct
      typedstruct do
        field :id, term(), enforce: true
        field :message, term(), enforce: true
        field :return_topic, ReturnTopic
      end

      @spec create(term(), ReturnTopic) :: t()
      @spec create(term(), ReturnTopic, term()) :: t()
      def create(message, return_topic, id \\ {__MODULE__, NaiveDateTime.utc_now()}) do
        %__MODULE__{id: id, message: message, return_topic: return_topic}
      end
    end
  end
end

import YDToolkit

entity BrandingTutorAccessMessage, do: use AccessMessage, domain: :branding, type: :entity, name: :tutor
entity BrandingTutoringBrandAccessMessage, do: use AccessMessage, domain: :branding, type: :entity, name: :tutoring_brand
entity BrandingCourseAccessMessage, do: use AccessMessage, domain: :branding, type: :aggregate, name: :course
entity BrandingHandlingEventAccessMessage, do: use AccessMessage, domain: :branding, type: :entity, name: :handling_event
#entity CourseAccessMessage, do: use AccessMessage, domain: :course
#entity ListingAccessMessage, do: use AccessMessage, domain: :listing
#entity PortfolioAccessMessage, do: use AccessMessage, domain: :portfolio
#entity SalesAccessMessage, do: use AccessMessage, domain: :sales


