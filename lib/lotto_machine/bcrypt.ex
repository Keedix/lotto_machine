defmodule LottoMachine.Bcrypt do
  @salt Application.get_env(:lotto_machine, :salt)

  @callback hash(String.t()) :: String.t()
  def hash(password) do
    Bcrypt.Base.hash_password(password, @salt)
  end
end
