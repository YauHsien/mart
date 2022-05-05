defmodule M.Domain.PricingAggregate.SKU do
  alias M.Domain.CustomerAggregate
  alias M.Domain.PricingAggregate.Promotion



  use TypedStruct

  @doc """
  Object: SKU
  Aggregate: Pricing
  """

  typedstruct do
    field :sku, String.t(), enforce: true
    field :promotion_list, Keyword.t(), default: []
  end



  @spec create(CustomerAggregate.Item.t()) :: t()

  def create(%CustomerAggregate.Item{} = item) do
    %__MODULE__{
      sku: item.sku
    }
  end



  @spec get_promotions(t()) :: [Promotion.t()]

  def get_promotions(sku),
    do: Keyword.keys(sku)



  @spec get_promotion(t(), Promotion.id()) :: Promotion.t() | nil

  def get_promotion(sku, promotion_id),
    do: Keyword.get(sku, promotion_id)



  @spec add_promotion(t(), Promotion.t()) :: t()

  def add_promotion(sku, promotion) do

    Keyword.put(
      sku.promotion_price_list,
      promotion.id,
      %Promotion{ promotion | sku: sku.sku }
    )

    sku
  end


end
