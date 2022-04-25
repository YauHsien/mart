defmodule M.Core.Common do
  alias Phoenix.PubSub


  defmacro accounting_pub_sub_name(), do: Accounting.PubSub
  defmacro backoffice_pub_sub_name(), do: Backoffice.PubSub
  defmacro classroom_pub_sub_name(), do: Classroom.PubSub
  defmacro env_pub_sub_name(), do: Env.PubSub
  defmacro finance_pub_sub_name(), do: Finance.PubSub
  defmacro lobby_pub_sub_name(), do: Lobby.PubSub
  defmacro member_pub_sub_name(), do: Member.PubSub
  defmacro portfolio_pub_sub_name(), do: Portfolio.PubSub
  defmacro repo_read_pub_sub_name(), do: Repo.Read.PubSub
  defmacro repo_write_pub_sub_name(), do: Repo.Write.PubSub
  defmacro sales_order_pub_sub_name(), do: SalesOrder.PubSub
  defmacro shop_pub_sub_name(), do: Shop.PubSub
  defmacro studio_pub_sub_name(), do: Studio.PubSub



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
