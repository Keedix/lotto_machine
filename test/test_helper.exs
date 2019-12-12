ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(LottoMachine.Repo, :manual)

Mox.defmock(LottoMachine.Generator.TestGen, for: LottoMachine.Generator)
Mox.defmock(LottoMachine.BcryptMock, for: LottoMachine.Bcrypt)
