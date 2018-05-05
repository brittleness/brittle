defmodule Mix.Tasks.Brittle.ImportTest do
  use ExUnit.Case, async: true
  alias Brittle.{Repo, Run}
  alias Mix.Tasks.Brittle.Import
  import Brittle.Fixtures

  test "imports a run" do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    payload =
      :run
      |> attributes()
      |> Jason.encode!()

    basename =
      DateTime.utc_now()
      |> DateTime.to_unix(:microsecond)
      |> Integer.to_string()

    File.mkdir_p!(payload_directory())

    payload_directory()
    |> Path.join(basename <> ".json")
    |> File.write!(payload)

    Import.run([])
    assert [%Run{revision: "df54993999a5b340c8d3949e526ae91dba09a351"}] = Repo.all(Run)
  end

  defp payload_directory do
    Application.get_env(
      :brittle_importer,
      :payload_directory,
      Path.join(System.user_home!(), "brittle/payloads")
    )
  end
end
