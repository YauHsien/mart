defmodule M.Repo.ReadOnlyRepo do
  use Ecto.Repo, otp_app: :mart_repo, adapter: Ecto.Adapters.Postgres, read_only: true
end
