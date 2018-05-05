defmodule Mix.Tasks.Brittle.Import do
  def run(_) do
    Application.ensure_all_started(:brittle_results)
    Mix.Tasks.Ecto.Migrate.run(~w(-r Brittle.Repo --quiet))

    Application.get_env(
      :brittle_importer,
      :payload_directory,
      Path.join(System.user_home!(), "brittle/payloads")
    )
    |> Path.join("*.json")
    |> Path.wildcard
    |> Enum.each(fn(payload) ->
      payload
      |> File.read!
      |> Jason.decode!(keys: :atoms!)
      |> Brittle.Results.create_run
    end)
  end
end
