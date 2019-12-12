defmodule LottoMachine.Number do
  use Ecto.Schema
  import Ecto.Query

  @bcrypt Application.get_env(:lotto_machine, :bcrypt)
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

  def by_username(query, username) do
    user_hash =
      username
      |> @bcrypt.hash()

    from(n in query, where: n.user_hash == ^user_hash)
  end

  def by_type(query, type) do
    from(n in query, where: n.type == ^type)
  end

  def selected(query) do
    from(n in query, select: %{inserted_at: n.inserted_at, numbers: n.numbers, type: n.type})
  end

  def maybe_sorted(query, params) do
    case Map.get(params, "sort") do
      "desc" ->
        from(n in query, order_by: [desc: n.inserted_at])

      "asc" ->
        from(n in query, order_by: [asc: n.inserted_at])

      _ ->
        query
    end
  end

  def limited(query, params) do
    limit = Map.get(params, "limit", "10") |> String.to_integer()

    from(n in query, limit: ^limit)
  end

  def by_offset(query, params) do
    case Map.get(params, "offset") do
      nil ->
        query

      offset ->
        from(n in query, offset: ^offset)
    end
  end
end
