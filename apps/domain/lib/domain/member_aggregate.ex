defmodule M.Domain.MemberAggregate do
  alias M.Domain.MemberAggregate.UserAccount


  @type username() :: {:username, String.t()}

  defmacro username(name),
    do: quote do: {:username, unquote(name)}



  @type password() :: {:password, String.t(), String.t(), NaiveDateTime.t()}

  defmacro password(password, salt, changed_when),
    do: quote do: {:password, unquote(password), unquote(salt), unquote(changed_when)}



  @type user_token() :: {:user_token, String.t(), NaiveDateTime.t()}
  @type user_token_list() :: [user_token()]

  defmacro user_token(token, expired_when),
    do: quote do: {:user_token, unquote(token), unquote(expired_when)}


  defdelegate create(username, password, datetime \\ NaiveDateTime.utc_now()),
    to: UserAccount

  defdelegate set_password(user_account, password, datetime \\ NaiveDateTime.utc_now()),
    to: UserAccount

  defdelegate verify_password(user_account, plain_password),
    to: UserAccount

  defdelegate new_token(user_account, expired_when \\ nil),
    to: UserAccount

  defdelegate renew_token(user_account, plain_token, expired_when \\ nil),
    to: UserAccount

end
