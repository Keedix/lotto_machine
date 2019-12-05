defmodule LottoMachine.Repo do
  use Ecto.Repo,
    otp_app: :lotto_machine,
    adapter: Ecto.Adapters.Postgres
end
