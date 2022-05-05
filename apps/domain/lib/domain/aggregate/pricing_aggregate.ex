defmodule M.Domain.Aggregate.PrcingAggregate do
	alias M.Domain.PricingAggregate.SKU
  alias M.Domain.PricingAggregate.Promotion



  defdelegate create(item), to: SKU

  defdelegate create_promotion(id, description, price), to: Promotion, as: :create

  defdelegate get_promotions(sku), to: SKU

  defdelegate get_promotion(sku, promotion_id), to: SKU

  defdelegate add_promotion(sku, promotion), to: SKU


end
