defmodule M.Core.Node do

  @wait_milliseconds_for_node_connection 200




  def connect_node(nodes, timeout \\ @wait_milliseconds_for_node_connection) do

    nodes
    |> Enum.map(&(
        if false == Enum.member?(:erlang.nodes(), &1), do: :net_kernel.connect_node(&1)
        ))

    :timer.sleep(timeout)
  end



end
