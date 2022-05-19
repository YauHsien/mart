import Config
alias M.Domain.ByGroup

config :mart_domain,
  repo_write_pub_sub: Node.Repo.Command.PubSub,
  repo_read_pub_sub: Node.Repo.Query.PubSub,
  repo_for_bought_package_model: Domain.BoughtPackageModel.Repository,
  repo_for_course_model: Domain.CourseModel.Repository,
  repo_for_customer_model: Domain.CustomerModel.Repository,
  repo_for_handling_event_model: Domain.HandingEventModel.Repository,
  repo_for_lecturing_specification_model: Domain.LecturingSpecificationModel.Repository,
  repo_for_listing_model: Domain.ListingModel.Repository,
  repo_for_payment_model: Domain.PaymentModel.Repository,
  repo_for_pricing_event_model: Domain.PricingEventModel.Repository,
  repo_for_room_model: Domain.RoomModel.Repository,
  repo_for_sales_order_model: Domain.SalesOrderModel.Repository,
  repo_for_transaction_event_model: Domain.TransactionEventModel.Repository,
  repo_for_tutor_model: Domain.TutorModel.Repository,
  repo_for_tutoring_brand_model: Domain.TutoringBrand.Repository,
  repo_for_using_event_model: Domain.UsingEventModel.Repository

config :ex_domain_toolkit,
  registry: Domain.Registry
