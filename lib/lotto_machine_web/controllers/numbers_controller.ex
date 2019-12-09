defmodule LottoMachineWeb.NumbersController do
  use LottoMachineWeb, :controller

  require Logger

  alias LottoMachine.{Generator, Repo, Number}

  def get_numbers_by_username(conn, %{"username" => u} = params) do
    numbers =
      Number
      |> Number.by_username(u)
      |> Number.selected()
      |> Number.maybe_sorted(params)
      |> Number.limited(params)
      |> Number.by_offset(params)
      |> Repo.all()

    conn
    |> json(%{data: numbers})
  end

  def get_numbers_by_username_and_type(conn, %{"username" => u, "type" => t} = params) do
    numbers =
      Number
      |> Number.by_username(u)
      |> Number.by_type(t)
      |> Number.selected()
      |> Number.maybe_sorted(params)
      |> Number.limited(params)
      |> Number.by_offset(params)
      |> Repo.all()

    conn
    |> json(%{data: numbers})
  end

  def create_numbers_by_username(conn, %{"username" => username, "type" => type}) do
    # Validate user access
    numbers =
      String.to_atom(type)
      |> Generator.generate()

    case Repo.insert_generated_numbers(numbers, username, type) do
      {:ok, data} ->
        Logger.debug(fn -> "Successfully inserted data #{inspect(data)}" end)

        conn
        |> json(%{data: %{numbers: numbers}})

      {:error, changeset} ->
        Logger.error("Failed to add new generated numbers: #{inspect(changeset)}")

        conn
        |> put_status(500)
        |> json(%{error: %{type: "Internal Server Error"}})
    end
  end
end
