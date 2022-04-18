defmodule M.Env.Server do
  use GenServer
  require M.Core.Server.Security
  require M.Core.Common
  alias M.Core.Common
  alias Phoenix.PubSub




  def start_link(args),
    do: GenServer.start_link(__MODULE__, args)




  def connect_node(server, node),
    do: GenServer.call(server, {:connect_node, node})




  @impl true

  def init(args) do

    nodes = Application.fetch_env!(:mart_env, :nodes)

    nodes |>
      Enum.map(&( if false == Enum.member?(:erlang.nodes(), &1),
         do: :net_kernel.connect_node(&1) ))
    sleep_by_config()
    # After a bit of a wait, nodes will be connected and then messages may pass.

    config_keys =
      Application.fetch_env!(:mart_env, :groups) |>
      Enum.map(&(
          fetch_env(&1, Application.fetch_env!(:mart_env, :"mart:env:#{&1}:keys"))
          )) |>
      List.flatten()

    config_keys |>
      Enum.map(&( PubSub.broadcast!(Common.repo_pub_sub_name(), "#{__MODULE__}:config:load", &1) ))

    state =
      %{
        public_key: get_public_key(),
        nodes: nodes,
        config_keys: config_keys,
        topic: "#{__MODULE__}:config:load"
      } |>
      Map.merge(Map.new(args))

    {:ok, state}
  end



  defp fetch_env(type, list),
    do: list |>
      Enum.map(&(
            case &1 do
              {subtype, key} when is_atom(key) ->
                case Application.fetch_env(:mart_env, key) do
                  {:ok, list_1} ->
                    fetch_env({type, subtype}, list_1)
                  :error ->
                    {type, subtype, key}
                end
              {subtype, value} ->
                {type, subtype, value}
            end ))







  @impl true

  def handle_call(request, from, state)


  def handle_call({:connect_node, node}, from, state) do

    result =
	  if false == Enum.member?(:erlang.nodes(), node) do
      :net_kernel.connect_node(node)
    else
      :duplicated
    end

    {:reply, {result, node}, state}
  end


  def handle_call(_request, _from, state),
    do: {:reply, state, state}









  defp get_public_key(),
    do: M.Core.Server.Security.get_private_key(:mart_env) |>
      ExPublicKey.RSAPrivateKey.get_public()




  defp sleep_by_config(),
    do: Application.fetch_env!(:mart_env, :wait_milliseconds_for_node_connection) |>
      then(&(
            case &1 do
              s when is_binary(s) -> String.to_integer(s)
              i when is_integer(i) -> i
            end
          )) |>
      :timer.sleep()




end
