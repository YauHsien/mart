defmodule M.MemberWeb.TokenController do
  use M.MemberWeb, :controller
  import Plug.Conn
  alias Jason
  alias M.Member.Repo
  alias M.Member.User.Account

  def users(conn, _params) do
    conn
    |> send_resp(200, Repo.user_accounts() |> Enum.map(&(&1|>Jason.encode!())))
  end

  def signup(conn, %{"username" => username, "password" => password}) do
    conn
    |> send_resp(200, Repo.create(username, password) |> then(&(
        case &1 do
          {:ok, %{user_account: user_account}} -> Jason.encode!(%{ status: :ok, result: user_account })
          {:error, :user_account, %Ecto.Changeset{errors: [username: {reason, [constraint: constraint, constraint_name: constraint_name]}]}, _map} ->
            Jason.encode!(%{ status: :error, description: "username #{reason}: #{constraint} #{constraint_name}" })
        end)) )
  end

  def login(conn, %{"token" => token}) do
    conn
    |> text(Repo.signin(token))
  end

  def login(conn, %{"username" => username, "password" => password}) do
    conn
    |> text(Repo.signin(username, password))
  end
end
