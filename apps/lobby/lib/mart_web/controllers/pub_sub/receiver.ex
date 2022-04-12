defmodule M.LobbyWeb.Controllers.PubSub.Receiver do
	use GenServer

  @type t() :: __MODULE__
  @type action() ::
  M.Member.Resource.Action.t() |
  M.Shop.Resource.Action.t()

  alias ExPublicKey.RSAPrivateKey
  require M.Core.Server.Security
  import M.Core.Server.Security, only: [get_private_key: 1]
  alias M.Lobby.Registry, as: MyRegistry
  alias M.Lobby.PubSub, as: MyPubSub
  alias Phoenix.PubSub
  alias Plug.Crypto

  @doc """

  Start a pub-sub receiver while subscribing a pub-sub server.

  # Options

  - `:pub_sub` of type Phoenix.PubSub.t() is the pub-sub server name.

  """
  def start_link(args),
    do: GenServer.start_link(__MODULE__, args, name: __MODULE__)




  @doc """

  # 要求 pub_sub_receiver 代理發送動作需求

  """

  @spec request(
    pub_sub_receiver :: GenServer.server(),
    from :: pid(),
    action_type :: action(),
    action_id :: any(),
    payload :: any()
  )  :: any()

  def request(pub_sub_receiver, from, action_type, action_id, payload),
    do: GenServer.cast(
          pub_sub_receiver,
          { :request,
            %{ from: from,
               action_type: inspect(action_type),
               action_id: action_id,
               payload: payload
            }
          })




  @impl true
  def init(args),
    do: {:ok, Map.merge(%{},Map.new(args))}




  @impl true
  def handle_cast(request, state)


  def handle_cast({:request, %{}=map}, state) do
    request(map.from, map.action_type, map.action_id, map.payload)
    {:noreply, state}
  end

  def handle_cast(_request, state),
    do: {:noreply, state}



  defp request(from, action_type, action_id, payload) do

    return_addr =
      Crypto.sign(
        get_private_key(:mart) |> RSAPrivateKey.get_fingerprint(),
        inspect(M.LobbyWeb.Controllers.PubSub.Receiver),
        "#{inspect action_type}:#{inspect action_id}:response")

    Registry.register(MyRegistry, return_addr, from)
    PubSub.subscribe(MyPubSub, return_addr)

    PubSub.broadcast!(MyPubSub, action_type,
      %{ action_id: action_id,
         payload: payload,
         return_addr: return_addr
      })
  end




  @impl true
  def handle_info(%{return_addr: return_addr}=msg, state),
    do: Registry.lookup(MyRegistry, return_addr)
    |> maybe_take_pub_sub_return(msg, state)
    |> then(&( {:noreply,&1} ))

  def handle_info(_msg, state),
    do: {:noreply, state}



  defp maybe_take_pub_sub_return([], _msg, state), do: state
  defp maybe_take_pub_sub_return(
    [{_my_pid, origin}],
    %{
      return_addr: return_addr,
      action_type: action_type,
      action_id: action_id,
      payload: payload
    },
    state
  ) do

    Registry.unregister(MyRegistry, return_addr)
    PubSub.unsubscribe(MyPubSub, return_addr)

    r_a_1 =
      Crypto.sign(
        get_private_key(:mart) |> RSAPrivateKey.get_fingerprint(),
        inspect(M.LobbyWeb.Controllers.PubSub.Receiver),
        "#{inspect action_type}:#{inspect action_id}:response")

    if (r_a_1 == return_addr),
      do: send(origin, payload)

    state
  end


end
