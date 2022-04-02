defmodule M.MemberWeb.ValidationController do
  use M.MemberWeb, :controller
  import Plug.Conn
  alias M.Member.Repo

  def validate(conn, %{"token" => token}) do
    conn
    |> text(Repo.verify(token))
  end
end
