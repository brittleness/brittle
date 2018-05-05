defmodule Brittle.Repo do
  use Ecto.Repo,
    otp_app: :brittle_results,
    adapter: Sqlite.Ecto2
end
