defmodule M.PortfolioTest do
  use ExUnit.Case
  doctest M.Portfolio

  test "greets the world" do
    assert M.Portfolio.hello() == :world
  end
end
