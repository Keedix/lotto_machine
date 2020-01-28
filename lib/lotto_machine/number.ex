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
    [subject, direction] = maybe_parse_sort(params)

    case direction do
      "desc" ->
        from(n in query, order_by: [desc: ^subject])

      "asc" ->
        from(n in query, order_by: [asc: ^subject])

      nil ->
        query
    end
  end

  def maybe_parse_sort(params) do
    case Map.get(params, "sort", nil) do
      nil ->
        [nil, nil]

      string ->
        splitted = String.split(string, " ")

        if length(splitted) != 2 do
          [nil, nil]
        else
          [
            splitted |> List.first() |> String.to_atom(),
            splitted |> List.last()
          ]
        end
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

  def distinct(query) do
    from(n in query, distinct: true)
  end

  def select_type(query) do
    from(n in query, select: n.type)
  end
end
