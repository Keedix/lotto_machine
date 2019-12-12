defmodule LottoMachine.GeneratorTest do
  use ExUnit.Case, async: true

  import Mox

  alias LottoMachine.Generator.{Lotto, MultiMulti}

  setup :verify_on_exit!

  test "should return 6 random numbers - lotto game" do
    actual = Lotto.generate()
    assert length(actual) == 6
  end

  test "should return 10 random numbers - mutli multi game" do
    actual = MultiMulti.generate()
    assert length(actual) == 10
  end

  test "should run custom lotto generator - LottoMachine.Generator.TestGen" do
    LottoMachine.Generator.TestGen
    |> expect(:generate, fn -> [1, 2, 3, 4, 5] end)

    assert LottoMachine.Generator.generate(:test_gen) == [1, 2, 3, 4, 5]
  end
end
