defmodule M.Domain.Application do
  use Application

  def start(_start_type, _start_args) do
    Supervisor.start_link(children(), strategy: :one_for_one, name: __MODULE__.Supervisor)
  end

  alias M.Domain.ByGroup.BoughtPackageRepository
  alias M.Domain.ByGroup.CourseRepository
  alias M.Domain.ByGroup.CustomerRepository
  alias M.Domain.ByGroup.HandlingEventRepository
  alias M.Domain.ByGroup.LecturingSpecificationRepository
  alias M.Domain.ByGroup.ListingRepository
  alias M.Domain.ByGroup.PaymentRepository
  alias M.Domain.ByGroup.PricingEventRepository
  alias M.Domain.ByGroup.RoomRepository
  alias M.Domain.ByGroup.SalesOrderRepository
  alias M.Domain.ByGroup.TransactionEventRepository
  alias M.Domain.ByGroup.TutorRepository
  alias M.Domain.ByGroup.TutoringBrandRepository
  alias M.Domain.ByGroup.UsingEventRepository

  defp children() do
    [
      {Registry, keys: :unique, name: Domain.Registry}
    ] ++ (
      [
        {         BoughtPackageRepository, :repo_for_bought_package_model         },
        {                CourseRepository, :repo_for_course_model                 },
        {              CustomerRepository, :repo_for_customer_model               },
        {         HandlingEventRepository, :repo_for_handling_event_model         },
        {LecturingSpecificationRepository, :repo_for_lecturing_specification_model},
        {               ListingRepository, :repo_for_listing_model                },
        {               PaymentRepository, :repo_for_payment_model                },
        {          PricingEventRepository, :repo_for_pricing_event_model          },
        {                  RoomRepository, :repo_for_room_model                   },
        {            SalesOrderRepository, :repo_for_sales_order_model            },
        {      TransactionEventRepository, :repo_for_transaction_event_model      },
        {                 TutorRepository, :repo_for_tutor_model                  },
        {         TutoringBrandRepository, :repo_for_tutoring_brand_model         },
        {            UsingEventRepository, :repo_for_using_event_model            }
      ]
      |> Enum.map(&via_reg(&1 |> elem(0), Domain.Registry, &1 |> elem(1)))
      |> Enum.filter(fn {:via, _, {_, nil}} -> false; _ -> true end)
    )
  end

  defp via_reg(repo, reg, key) do
    {repo, name: {:via, Registry, {reg,
                                   Application.fetch_env!(:mart_domain, key)}}}
  end
end
