defmodule M.Core.Common do
  alias Phoenix.PubSub



  alias Timex.Timezone
  alias UUID

  def get_uuid(category) do
    Timezone.local().full_name|>DateTime.now!()|>to_string()|>then(&(category<>&1))
  end




  @timeout 900
  @try_connect_key_prefix "try connect"

  defmacro timeout, do: @timeout
  defmacro try_connect_key_prefix, do: @try_connect_key_prefix
  defmacro try_connect_key, do: NaiveDateTime.utc_now() |> NaiveDateTime.to_gregorian_seconds() |> then(&("#{@try_connect_key_prefix} #{inspect &1}"))



  @spec try_connect(PubSub.t(), PubSub.t()) :: boolean()
  @spec try_connect(PubSub.t(), PubSub.t(), timeout :: Integer.t()) :: boolean()

  def try_connect(to_pub_sub, replay_to_pub_sub, timeout \\ @timeout) do

    try_key = try_connect_key()
    PubSub.subscribe(replay_to_pub_sub, try_key)

    PubSub.broadcast!(to_pub_sub, @try_connect_key_prefix, try_key)

    receive do
      try_key ->
        PubSub.unsubscribe(replay_to_pub_sub, try_key)
        true
    after
      timeout ->
        PubSub.unsubscribe(replay_to_pub_sub, try_key)
        false
    end
  end




  @spec command(from :: PubSub.t(), to :: PubSub.t(), resource :: PubSub.topic(), command :: map()) :: result :: (map() | false)

  @spec command(from :: PubSub.t(), to :: PubSub.t(), resource :: PubSub.topic(), command :: map(), timeout :: Integer.t()) :: result :: (map() | false)

  def command(from, to, resource, command, timeout \\ @timeout) do

    return_addr =
      NaiveDateTime.utc_now() |>
      NaiveDateTime.to_gregorian_seconds() |>
      then(&("#{resource}:#{inspect &1}"))

    PubSub.subscribe(from, return_addr)

    PubSub.broadcast!(to, resource, %{command|pub_sub_name: from, return_addr: return_addr})

    receive do
      map_or_false ->
        PubSub.unsubscribe(from, return_addr)
        map_or_false
    after
      timeout ->
        PubSub.unsubscribe(from, return_addr)
        false
    end
  end




end
