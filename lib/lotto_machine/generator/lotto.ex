defmodule LottoMachine.Generator.Lotto do
  @behaviour LottoMachine.Generator

  def generate() do
    LottoMachine.Generator.generate_numbers(6, 49)
  end
end
