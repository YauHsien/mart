defmodule M.LobbyWeb.Controllers.PubSub.ReceiverTest do
  use ExUnit.Case, async: true

  alias M.LobbyWeb.Controllers.PubSub.Receiver

  test "M.LobbyWeb.Controllers.PubSub.Receiver (a gen-server)" do

    key = {:action, :"an action type"}
    Phoenix.PubSub.subscribe(M.Lobby.PubSub, inspect(key))
    Receiver.request(Receiver, self(), key, 1, "hello,world")


    result =
      receive do value -> value
    after 30 -> "no response" end

    assert "no response" == result


    result =
      receive do value -> value
    after 1000 -> "no response" end

    assert %{
      action_id: 1,
      payload: "hello,world",
      return_addr: _return_addr # It may be expired and can be verified.
    } = result

  end
end
