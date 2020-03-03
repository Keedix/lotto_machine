defmodule LottoMachine.Number do
  use Ecto.Schema
  import Ecto.Query

  @timestamps_opts [type: :utc_datetime]

  schema "lotto_numbers" do
    field :numbers, {:array, :integer}
    field :user_hash, :string
    field :type, :string

    timestamps()
  end

  def changeset(number, params \\ %{}) do
    number
    |> Ecto.Changeset.cast(params, [:numbers, :user_hash, :type])
    |> Ecto.Changeset.validate_required([:numbers, :user_hash, :type])
  end

  def get_numbers(number) do
    number
    |> changeset()
    |> Ecto.Changeset.fetch_field!(:numbers)
  end
end
