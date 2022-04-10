defmodule M.CoreTest do
  use ExUnit.Case
  doctest M.Core

  test "greets the world" do
    assert M.Core.hello() == :world
  end
end
