defmodule M.Member.User.Account.Password do
  alias Ecto.Changeset
  alias Plug.Crypto
  alias Timex.Timezone

  @spec maybe_change_password(Ecto.Changeset.t()) :: map
  def maybe_change_password(changeset) do
    changeset
    |> Changeset.get_change(:password)
    |> maybe_change_password_in(changeset)
  end

  defp maybe_change_password_in(nil, changeset), do: changeset
  defp maybe_change_password_in(password0, changeset) do
    changeset
    |> Changeset.get_field(:salt)
    |> maybe_change_password(password0, in: changeset)
  end

  defp maybe_change_password(nil, _password, in: changeset), do: changeset # 無效資料，不處理。
  defp maybe_change_password(salt, password0, in: changeset) do
    changeset
    |> Changeset.get_field(:username)
    |> maybe_change_password(password0, salt, in: changeset)
  end

  defp maybe_change_password(nil, _password, _salt, in: changeset), do: changeset # 無效資料，不處理。
  defp maybe_change_password(username, password0, salt, in: changeset) do
    password = Crypto.sign(password0, salt, username)
    password_changed_when = DateTime.now!(Timezone.local.full_name)
    changeset
    |> Changeset.cast(%{password: password, password_changed_when: password_changed_when}, [:password, :password_changed_when])
  end

end
