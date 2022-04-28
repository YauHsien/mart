import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mart_backoffice, M.BackOfficeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RvEqgqM6NZ9aBSYh5qZYsD5GolQx9Q756y3sU2g7vrJtBvjR90Ifl0aGLuA9RSeW",
  server: false

# In test we don't send emails.
config :mart_backoffice, M.BackOffice.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
