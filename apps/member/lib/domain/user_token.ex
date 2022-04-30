defmodule M.Domain.Member.UserToken do
  require M.Domain.Member
  alias Plug.Crypto



  @spec create(M.Domain.Member.username(), M.Domain.Member.password) ::
  M.Domain.Member.user_token()

  @spec create(M.Domain.Member.username(), M.Domain.Member.password, NaiveDateTime.t()) ::
  M.Domain.Member.user_token()

  def create(M.Domain.Member.username(username), M.Domain.Member.password(password, salt, _), expired_when \\ nil) do

    expired_when = maybe_find_datetime(expired_when)
    user_token = Crypto.sign(password, salt, username)

    M.Domain.Member.user_token(user_token, expired_when)
  end



  defp maybe_find_datetime(nil),
    do: NaiveDateTime.add(NaiveDateTime.utc_now(), (24 * 60 * 60), :second)

  defp maybe_find_datetime(datetime),
    do: datetime




end
