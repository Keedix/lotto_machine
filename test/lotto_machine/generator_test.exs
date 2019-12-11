defmodule LottoMachine.GeneratorTest do
  use ExUnit.Case, async: true

  alias LottoMachine.Generator.{Lotto, MultiMulti}

  test "should return 6 random numbers - lotto game" do
    actual = Lotto.generate()
    assert length(actual) == 6
  end

  test "should return 10 random numbers - mutli multi game" do
    actual = MultiMulti.generate()
    assert length(actual) == 10
  end
end
