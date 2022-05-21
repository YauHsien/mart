defmodule M.DataCacheTest do
  use ExUnit.Case
  doctest M.DataCache

  test "greets the world" do
    assert M.DataCache.hello() == :world
  end
end
