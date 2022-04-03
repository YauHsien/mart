defmodule M.MemberWeb.TokenController do
  use M.MemberWeb, :controller
  import Plug.Conn
  alias Jason
  alias M.Member.Repo
  alias M.Member.User.Account
  alias Map

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

  def signin_by_username(conn, %{"username" => username, "password" => password}) do
    conn
    |> send_resp(200, Repo.signin(username, password) |> then(&(
        case &1 do
          {:ok, user_account}->
            Jason.encode!(%{ status: :ok, token: Map.get(user_account, :user_token), expired_when: Map.get(user_account, :expired_when) })
          {:error, :failed} ->
            Jason.encode!(%{ status: :error, description: "login failed with that username and password" })
        end)))
  end
end
