defmodule LottoMachineWeb.NumbersControllerTest do
  use LottoMachineWeb.ConnCase

  import Mox

  describe "get_numbers_by_username/2" do
    test "should get empty list of numbers", %{conn: conn} do
      LottoMachine.BcryptMock
      |> expect(:hash, fn password -> password end)

      response =
        conn
        |> put_req_header("authorization", "Bearer fake_token")
        |> get(Routes.numbers_path(conn, :get_numbers_by_username, "auklejewski"))
        |> json_response(200)

      assert response == %{"data" => []}
    end

    test "should get list of numbers", %{conn: conn} do
      username = "auklejewski"
      numbers = [1, 2, 3, 4, 5, 6, 7]
      type = "custom_game"

      user_hash = "auklejewski_hash"

      LottoMachine.BcryptMock
      |> expect(:hash, 2, fn _password -> user_hash end)

      {:ok, draw} = LottoMachine.Repo.insert_generated_numbers(numbers, username, type)

      response =
        conn
        |> put_req_header("authorization", "Bearer fake_token")
        |> get(Routes.numbers_path(conn, :get_numbers_by_username, username))
        |> json_response(200)

      assert response ==
               Jason.decode!(
                 Jason.encode!(%{
                   "data" => [
                     %{
                       "inserted_at" => draw.inserted_at,
                       "numbers" => numbers,
                       "type" => type
                     }
                   ]
                 })
               )
    end
  end

  describe "get_numbers_types/2" do
    test "should get empty list of types" do
      response =
        conn
        |> put_req_header("authorization", "Bearer fake_token")
        |> get(Routes.numbers_path(conn, :get_numbers_types))
        |> json_response(200)

      assert response == %{
               "data" => %{
                 "types" => []
               }
             }
    end

    test "should get list of types and sorted list of types" do
      username = "auklejewski"
      user_hash = "auklejewski_hash"

      LottoMachine.BcryptMock
      |> expect(:hash, 2, fn _password -> user_hash end)

      {:ok, _} = LottoMachine.Repo.insert_generated_numbers([12, 3, 4], username, "multi_multi")

      {:ok, _} = LottoMachine.Repo.insert_generated_numbers([12, 2, 3, 4, 5], username, "lotto")

      response =
        conn
        |> put_req_header("authorization", "Bearer fake_token")
        |> get(Routes.numbers_path(conn, :get_numbers_types))
        |> json_response(200)

      assert response == %{
               "data" => %{
                 "types" => ["multi_multi", "lotto"]
               }
             }

      response =
        conn
        |> put_req_header("authorization", "Bearer fake_token")
        |> get(Routes.numbers_path(conn, :get_numbers_types), sort: "type asc")
        |> json_response(200)

      assert response == %{
               "data" => %{
                 "types" => ["lotto", "multi_multi"]
               }
             }
    end
  end
end
