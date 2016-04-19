use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :find_meetups, FindMeetups.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :find_meetups, FindMeetups.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "find_meetups_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
