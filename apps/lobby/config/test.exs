import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mart, M.LobbyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Xi01XoaRjvaCCfL8u3fHvk1z87VWsM4OxOQ7JyH5Vgmdhkn6/4AM9rso8AHv/760",
  server: false

# In test we don't send emails.
config :mart, M.Lobby.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
