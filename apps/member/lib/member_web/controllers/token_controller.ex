defmodule M.MemberWeb.TokenController do
  use M.MemberWeb, :controller
  import Plug.Conn
  alias Jason
  alias M.Member.Repo
  alias M.Member.Session.Account
  alias M.Member.Session.Registry

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

  def maybe_update_token(conn, %{"token" => token}) do
    conn
    |> send_resp(200, Repo.maybe_update(token) |> then(&(
        case &1 do
          {:ok, token, expired_when} ->
            Jason.encode!(%{ status: :ok, token: token, expired_when: expired_when })
          {:error, issue} ->
            Jason.encode!(%{ status: :error, description: issue })
        end)))
  end

  def signin_by_username(conn, %{"username" => username, "password" => password}) do
    conn
    |> send_resp(200, Registry.find_user_by_username(Registry, username, password) |> then(&(
        case &1 do
          {:ok, user_pid}->
            token = Account.get_user_token(user_pid)
            Jason.encode!(%{ status: :ok, token: elem(token,0), expired_when: elem(token,1) })
          {:error, _reason} ->
            Jason.encode!(%{ status: :error, description: "login failed with that username and password" })
        end)))
  end
end
