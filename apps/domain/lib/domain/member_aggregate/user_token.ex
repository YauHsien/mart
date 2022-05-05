defmodule M.Domain.MemberAggregate.UserToken do
  require M.Domain.Aggregate.MemberAggregate
  alias   M.Domain.Aggregate.MemberAggregate
  alias Plug.Crypto



  @spec create(MemberAggregate.username(), MemberAggregate.password) ::
  MemberAggregate.user_token()

  @spec create(MemberAggregate.username(), MemberAggregate.password, NaiveDateTime.t()) ::
  MemberAggregate.user_token()

  def create(MemberAggregate.username(username), MemberAggregate.password(password, salt, _), expired_when \\ nil) do

    expired_when = maybe_find_datetime(expired_when)
    user_token = Crypto.sign(password, salt, username)

    MemberAggregate.user_token(user_token, expired_when)
  end



  defp maybe_find_datetime(nil),
    do: NaiveDateTime.add(NaiveDateTime.utc_now(), (24 * 60 * 60), :second)

  defp maybe_find_datetime(datetime),
    do: datetime




end
