defmodule M.Repo.ReadWriteRepository do
  use Ecto.Repo, otp_app: :mart_app, adapter: Ecto.Adapters.Postgres
end
