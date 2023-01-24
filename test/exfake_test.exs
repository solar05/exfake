defmodule ExfakeTest do
  use ExUnit.Case
  doctest Exfake

  test "greets the world" do
    assert Exfake.hello() == :world
  end
end
