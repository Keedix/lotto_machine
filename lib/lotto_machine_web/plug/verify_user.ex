defmodule LottMachineWeb.Plug.VerifyUser do
  import Plug.Conn

  defmodule AuthenticationFailure do
    @moduledoc """
    Error raised when access token is missing or invalid.
    """

    defexception message: "Unauthorized", plug_status: 401
  end

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> get_req_header("authorization")
    |> verify_request!()

    conn
  end

  defp verify_request!([acces_token]) do
    verified = String.length(acces_token) > 0
    unless verified, do: raise(AuthenticationFailure)
  end

  defp verify_request!(_), do: raise(AuthenticationFailure)
end
