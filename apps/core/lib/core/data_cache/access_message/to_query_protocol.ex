import Ecto.Query
alias M.Core.DataCache
alias M.Core.MartRepo
alias DataCache.AccessMessage
alias DataCache.BrandingTutorAccessMessage
alias DataCache.BrandingTutoringBrandAccessMessage
alias DataCache.BrandingCourseAccessMessage
alias DataCache.BrandingHandlingEventAccessMessage
alias MartRepo.Course
alias MartRepo.HandlingEvent
alias MartRepo.Lesson
alias MartRepo.Shop
alias MartRepo.Tutorship
alias MartRepo.User

defprotocol AccessMessage.ToQueryProtocol do
  @moduledoc """
  Protocol to convert a Access Message to Query.
  """
  @spec access_by(struct()) :: Ecto.Query.t()
  def access_by(acccess_message)
end

quote do
defimpl AccessMessage.ToQueryProtocol, for: UserAccountAccessMessage do
  def access_by(%UserAccountAccessMessage{message: {:id, id}}) do
    from u in User.Account, where: u.id == ^id
  end
end

defimpl AccessMessage.ToQueryProtocol, for: BrandingTutorAccessMessage do
  def access_by(%BrandingTutorAccessMessage{message: {:id, id}}) do
    from t in Tutorship, join: a in User.Account, on: t.user_account_id == a.id,
      where: t.id == ^id,
      select: [id: t.id, name: a.name]
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
  def access_by(%BrandingCourseAccessMessage{message: {:id, id}}) do
    course_plan_id = from c in Course, where: c.id == ^id, select: c.course_plan_id
    agenda = from p in Course.Plan, where: p.id == ^course_plan_id, select: [p.name, p.description]
    lessons = from l in Lesson, where: l.course_id == ^id
    from c in Course, select: [id: ^id, name: c.name, agenda: ^agenda, lessons: ^lessons, handling_events: []]
  end
end
defimpl AccessMessage.ToQueryProtocol, for: BrandingHandlingEventAccessMessage do
  def access_by(%BrandingHandlingEventAccessMessage{message: {:id, id}}) do
    from h in HandlingEvent, where: h.id == ^id
  end
end
end
