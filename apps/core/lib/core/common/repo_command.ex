defmodule M.Core.Common.RepoCommand do
  require M.Core.Common
  alias M.Core.Common
  defmacro repo_query(), do: "repo query"
  defmacro repo_command(), do: "repo command"
end
