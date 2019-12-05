defmodule LottoMachine.Generator do
  @type game :: atom()

  @spec generate(game()) :: [integer()]
  def generate(:lotto) do
    generate_numbers(6, 49)
  end

  def generate(:multi_multi) do
    generate_numbers(10, 80)
  end

  defp generate_numbers(count, max_numbers, acc \\ [])
  defp generate_numbers(0, _, acc), do: acc

  defp generate_numbers(count, max_number, acc) do
    new_acc = [Enum.random(1..max_number) | acc]
    generate_numbers(count - 1, max_number, new_acc)
  end
end
