defmodule M.Repo.Repo do
  use Ecto.Repo,
    otp_app: :mart_repo,
    adapter: Ecto.Adapters.Postgres
end
