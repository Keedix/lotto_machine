defmodule LottoMachine.Repo do
  use Ecto.Repo,
    otp_app: :lotto_machine,
    adapter: Ecto.Adapters.Postgres

  alias LottoMachine.Number

  @bcrypt Application.get_env(:lotto_machine, :bcrypt)

  def insert_generated_numbers(numbers, username, type) do
    user_hash = @bcrypt.hash(username)

    %Number{
      user_hash: user_hash,
      numbers: numbers,
      type: type
    }
    |> Number.changeset()
    |> __MODULE__.insert()
  end
end
