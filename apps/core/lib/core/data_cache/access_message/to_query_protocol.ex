import Ecto.Query
alias M.Core.DataCache
alias M.Core.MartRepo
alias DataCache.AccessMessage
alias DataCache.BrandingTutorAccessMessage
alias DataCache.BrandingTutoringBrandAccessMessage
alias DataCache.BrandingCourseAccessMessage
alias DataCache.BrandingHandlingEventAccessMessage
alias MartRepo.Shop
alias MartRepo.Tutorship

defprotocol AccessMessage.ToQueryProtocol do
  @spec access_by(struct()) :: Ecto.Query.t()
  def access_by(acccess_message)
end

defimpl AccessMessage.ToQueryProtocol, for: BrandingTutorAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
defimpl AccessMessage.ToQueryProtocol, for: BrandingTutoringBrandAccessMessage do
  def access_by(%BrandingTutoringBrandAccessMessage{message: {:id, id}}) do
    owners = from t in Tutorship, where: t.shop_id == ^id and t.is_owner, select: t.id
    partners = from t in Tutorship, where: t.shop_id == ^id and not(t.is_owner), select: t.id
    from s in Shop,
      select: [id: s.id, name: s.name, date: s.inserted_at,
               owners: ^owners, partners: ^partners]
  end
end
defimpl AccessMessage.ToQueryProtocol, for: BrandingCourseAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
defimpl AccessMessage.ToQueryProtocol, for: BrandingHandlingEventAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
