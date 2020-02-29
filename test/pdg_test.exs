defmodule PdgTest do
  use ExUnit.Case
  doctest Pdg

  test "greets the world" do
    assert Pdg.hello() == :world
  end
end
