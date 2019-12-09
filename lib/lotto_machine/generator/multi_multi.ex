defmodule LottoMachine.Generator.MultiMulti do
  @behaviour LottoMachine.Generator

  def generate() do
    LottoMachine.Generator.generate_numbers(10, 80)
  end
end
