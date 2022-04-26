defmodule M.Core.Common.RepoCommand do
  require M.Core.Common
  alias M.Core.Common

  @comment_topic_list """
  # Recommandation on Phoenix.PubSub.broadcast!

  - Topic: for example, `#{__MODULE__}.list(:user_account) |> #{__MODULE__}.topic()`, as `"topic {:list, :user_account}"`.
  - Message: for example, `#{__MODULE__}.list(:user_account)`, as `{:list, :user_account}`.

  Return from subscription:

  - Topic: for example, `#{__MODULE__}.list(:user_account) |> #{__MODULE__}.topic() |> #{__MODULE__}.return()`, as `"return topic {:list, :user_account}"`.
  - Return value: a sequence of `{:object, :user_account, id: id}`, for example, `{:object, :user_account, id: 1}`,
  followed by `{:object, :user_account, id: 2}`, followed by `{:object, :user_account, id: 3}`, and et al.
  """

  @comment_topic_rest ""
  @comment_return_rest ""

  @doc @comment_topic_list
  defmacro list(things), do: {:list, things}

  defmacro repo_query(), do: "repo query"
  defmacro repo_command(), do: "repo command"

  @doc @comment_topic_list <> @comment_topic_rest
  defmacro topic(name), do: "topic #{inspect name}"

  @doc @comment_topic_list <> @comment_return_rest
  defmacro return(topic), do: "return #{topic}"
end
