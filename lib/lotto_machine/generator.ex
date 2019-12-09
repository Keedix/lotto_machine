defmodule LottoMachine.Generator do
  @callback generate() :: [integer()]

  @type game() :: atom()

  @generators Application.get_env(:lotto_machine, :generators)

  @spec generate(game()) :: [integer()]
  def generate(type) do
    {_, module} = Enum.find(@generators, fn {t, _} -> type == t end)
    :erlang.apply(module, :generate, [])
  end

  def generate_numbers(count, max_numbers, acc \\ [])
  def generate_numbers(0, _, acc), do: acc

  def generate_numbers(count, max_number, acc) do
    new_acc = [Enum.random(1..max_number) | acc]
    generate_numbers(count - 1, max_number, new_acc)
  end
end
