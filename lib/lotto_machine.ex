defmodule LottoMachine do
  @moduledoc """
  LottoMachine keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def create_rsp_body(body) do
    %{data: body}
  end
end
