defmodule LottoMachineWeb.NumbersController do
  use LottoMachineWeb, :controller

  def get_numbers_by_username(conn, _params) do
    conn
    |> json(%{numbers: []})
  end
end
