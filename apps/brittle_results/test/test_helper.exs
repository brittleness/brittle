ExUnit.start(formatters: [Brittle.ExUnit, ExUnit.CLIFormatter])

Ecto.Adapters.SQL.Sandbox.mode(Brittle.Repo, :manual)
