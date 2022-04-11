defmodule M.Member.Resource.Action do

  @type t() :: {:action, atom()}

	defmacro action_member_password, do: {:action, :'member:password'}

end
