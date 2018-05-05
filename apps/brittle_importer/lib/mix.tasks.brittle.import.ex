defmodule Mix.Tasks.Brittle.Import do
  def run(_) do
    Application.ensure_all_started(:brittle_results)
    Mix.Tasks.Ecto.Migrate.run(~w(-r Brittle.Repo --quiet))

    Brittle.Importer.import!()
  end
end
