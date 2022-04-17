import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mart_studio, M.StudioWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "XWez+gKDVdoAVdkC2bSn162ntAstLP5abNyU7KNLyaaqHSq+dM5U5ZkYO2UkdSwb",
  server: false

# In test we don't send emails.
config :mart_studio, M.Studio.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
