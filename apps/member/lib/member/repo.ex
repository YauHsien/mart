defmodule M.Member.Repo do
  use Ecto.Repo,
    otp_app: :member,
    adapter: Ecto.Adapters.Postgres
end
