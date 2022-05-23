alias M.Core.DataCache
alias DataCache.AccessMessage
alias DataCache.BrandingAccessMessage
alias DataCache.CourseAccessMessage
alias DataCache.ListingAccessMessage
alias DataCache.PortfolioAccessMessage
alias DataCache.SalesAccessMessage

defmodule AccessMessage do
  @range [:branding, :portfolio, :course, :listing, :sales]
  defmacro __using__(type) when type in @range do
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

entity BrandingAccessMessage, do: use AccessMessage, :branding
entity CourseAccessMessage, do: use AccessMessage, :course
entity ListingAccessMessage, do: use AccessMessage, :listing
entity PortfolioAccessMessage, do: use AccessMessage, :portfolio
entity SalesAccessMessage, do: use AccessMessage, :sales


