defmodule LottoMachine.Numbers do
  @moduledoc """
  Context module
  """

  import Ecto.Query
  alias LottoMachine.{Number, Repo}

  @bcrypt Application.get_env(:lotto_machine, :bcrypt)
  @default_limit "10"

  def all_by_username(username, params) do
    Number
    |> by_username(username)
    |> selected()
    |> maybe_sorted(params)
    |> limited(params)
    |> by_offset(params)
    |> Repo.all()
  end

  def all_by_username_and_type(username, type, params) do
    Number
    |> by_username(username)
    |> by_type(type)
    |> selected()
    |> maybe_sorted(params)
    |> limited(params)
    |> by_offset(params)
    |> Repo.all()
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
    limit = Map.get(params, "limit", @default_limit) |> String.to_integer()

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
