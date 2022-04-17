defmodule M.ClassroomTest do
  use ExUnit.Case
  doctest M.Classroom

  test "greets the world" do
    assert M.Classroom.hello() == :world
  end
end
