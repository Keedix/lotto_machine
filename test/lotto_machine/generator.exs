defmodule LottoMachine.GeneratorTest do
  use ExUnit.Case, async: true

  test "should return 6 random numbers" do
    actual = LottoMachine.Generator.generate(:lotto)

    assert actual == []
  end
end
