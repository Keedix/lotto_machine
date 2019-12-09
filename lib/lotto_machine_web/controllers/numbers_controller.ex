defmodule LottoMachineWeb.NumbersController do
  use LottoMachineWeb, :controller

  require Logger

  alias LottoMachine.{Generator, Repo, Number}

  def get_numbers_by_username(conn, %{"username" => username, "type" => type}) do
    # Validate user access

    numbers =
      username
      |> Repo.get_user_numbers(type)

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
