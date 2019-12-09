defmodule LottoMachine.Repo do
  use Ecto.Repo,
    otp_app: :lotto_machine,
    adapter: Ecto.Adapters.Postgres

  alias LottoMachine.Number
  import Ecto.Query, only: [from: 2]

  @salt Application.get_env(:lotto_machine, :salt)

  def insert_generated_numbers(numbers, username, type) do
    user_hash = Bcrypt.Base.hash_password(username, @salt)

    %Number{
      user_hash: user_hash,
      numbers: numbers,
      type: type
    }
    |> Number.changeset()
    |> __MODULE__.insert()
  end
end
