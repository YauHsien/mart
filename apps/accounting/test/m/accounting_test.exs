defmodule M.AccountingTest do
  use ExUnit.Case
  doctest M.Accounting

  test "greets the world" do
    assert M.Accounting.hello() == :world
  end
end
