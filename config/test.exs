import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :faulkner, Faulkner.Repo,
  username: "postgres",
  password: "postgres",
  database: "faulkner_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :faulkner, FaulknerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "QeCdi1w75v4ha4Eo5wzJupTUjic2qJ5L+XqmimAQKI7Sdbr3v/XqSejcQg/H7VB2",
  server: false

# In test we don't send emails.
config :faulkner, Faulkner.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
