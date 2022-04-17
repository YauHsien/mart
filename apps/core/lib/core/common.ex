defmodule M.Core.Common do
  alias Phoenix.PubSub

  @timeout 900

  defmacro timeout, do: @timeout



  @spec try_connect(PubSub.t(), PubSub.t()) :: boolean()

  def try_connect(to_pub_sub, replay_to_pub_sub) do

    try_key = "try connect #{ts}"
    PubSub.subscribe(replay_to_pub_sub, try_key)

    PubSub.broadcast!(to_pub_sub, try_key, try_key)

    try do
      try_key ->
        PubSub.unsubscribe(replay_to_pub_sub, try_key)
        true
    after
      @timeout ->
        PubSub.unsubcribe(replay_to_pub_sub, try_key)
        false
    end
  end



end
