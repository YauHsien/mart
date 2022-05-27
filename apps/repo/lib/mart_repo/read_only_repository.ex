defmodule M.Repo.ReadOnlyRepository do
  use Ecto.Repo, otp_app: :mart_app, adapter: Ecto.Adapters.Postgres, read_only: true
end
