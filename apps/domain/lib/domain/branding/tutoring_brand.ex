defmodule M.Domain.Branding.TutoringBrand do
  use M.Domain.Stereotype, :entity

  alias M.Domain.Branding.TutoringAggregate.Tutor
  alias M.Domain.Course.CourseAgendaAggregate.CourseAgenda
  alias M.Domain.MemberAggregate.UserAccount

  use TypedStruct
  typedstruct do
    field :sku_to_corse_agenda_map, [{:string, CourseAgenda.t}], default: []
  end

end
