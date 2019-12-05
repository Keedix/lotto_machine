defmodule LottoMachine.GeneratorTest do
  use ExUnit.Case, async: true

  test "should return 6 random numbers - lotto game" do
    actual = LottoMachine.Generator.generate(:lotto)

    assert length(actual) == 6

    actual = LottoMachine.Generator.generate("lotto")

    assert length(actual) == 6
  end

  test "should return 10 random numbers - mutli multi game" do
    actual = LottoMachine.Generator.generate(:multi_multi)

    assert length(actual) == 10

    actual = LottoMachine.Generator.generate("multi_multi")

    assert length(actual) == 10
  end
end
