defmodule M.Domain.Member do



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



end
