defmodule Brittle.Repo do
  config =
    Application.get_env(:brittle_results, Brittle.Repo, adapter: Sqlite.Ecto2)

  use Ecto.Repo,
    otp_app: :brittle_results,
    adapter: config[:adapter]
end
