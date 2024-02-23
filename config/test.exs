import Config

# Database config
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :orbit, Orbit.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "orbit_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :orbit, OrbitWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "rkME9iHy9nN19cmr5XjoM1hJDX9m2KKjJXUkIRSzgnRWg8IVn8yGaGCNkzEQxkBD",
  server: false

config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
