defmodule M.Repo.Repo do
  use Ecto.Repo,
    otp_app: :mart_repo,
    adapter: Ecto.Adapters.Postgres
  alias M.Repo.Basket
  alias M.Repo.Bought
  alias M.Repo.Course
  alias M.Repo.Lecturer
  alias M.Repo.Lession
  alias M.Repo.Payment
  alias M.Repo.Pricing
  alias M.Repo.Promotion
  alias M.Repo.Room
  alias M.Repo.SalesOrder
  alias M.Repo.Shop
  alias M.Repo.SKU
  alias M.Repo.Studentship
  alias M.Repo.Tutorship
  alias M.Repo.User
end
