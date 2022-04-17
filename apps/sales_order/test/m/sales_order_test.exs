defmodule M.SalesOrderTest do
  use ExUnit.Case
  doctest M.SalesOrder

  test "greets the world" do
    assert M.SalesOrder.hello() == :world
  end
end
