use Mix.Config

# Configure your database
config :lotto_machine, LottoMachine.Repo,
  username: "postgres",
  password: "postgres",
  database: "lotto_machine_test",
  hostname: System.get_env("DB_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lotto_machine, LottoMachineWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :lotto_machine,
  bcrypt: LottoMachine.BcryptMock,
  generators: [{:test_gen, LottoMachine.Generator.TestGen}]
