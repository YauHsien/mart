import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mart_finance, M.FinanceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "lNZ1LNldyGpMRR09iRYxSmLjX+TbcqEMLus6aulMyX7VmS+6BxWEMkOkWxLjNK7M",
  server: false

# In test we don't send emails.
config :mart_finance, M.Finance.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
