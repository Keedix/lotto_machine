defmodule LottoMachineWeb.Router do
  use LottoMachineWeb, :router
  use Plug.ErrorHandler
  alias LottMachineWeb.Plug.VerifyUser

  pipeline :api do
    plug :accepts, ["json"]
    plug VerifyUser
  end

  scope "/api", LottoMachineWeb do
    pipe_through :api

    get("/users/:username/numbers", NumbersController, :get_numbers_by_username)
    get("/users/:username/numbers/:type", NumbersController, :get_numbers_by_username)
    post("/users/:username/numbers/:type", NumbersController, :create_numbers_by_username)
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
