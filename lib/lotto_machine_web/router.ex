defmodule LottoMachineWeb.Router do
  use LottoMachineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LottoMachineWeb do
    pipe_through :api

    get("/users/:username/:type/:numbers", NumbersController, :get_numbers_by_username)
  end
end
