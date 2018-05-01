defmodule Brittle.Fixtures do
  alias Brittle.{Repo, Suite, Run}

  def fixture(:suite) do
    %Suite{
      name: "phoenix",
      inserted_at: ~N[2018-05-01 21:32:21.097299],
      updated_at: ~N[2018-05-01 21:32:21.097312]
    }
  end

  def fixture(:run) do
    %Run{
      branch: "master",
      digest: "5e40eb035846ae6e762cbd22e65c34f3",
      dirty: true,
      duration: 20713727,
      excluded_count: 0,
      failure_count: 0,
      hostname: "Alices-MBP.fritz.box",
      revision: "df54993999a5b340c8d3949e526ae91dba09a351",
      test_count: 617,
      suite: fixture(:suite),
      inserted_at: ~N[2018-05-01 21:33:32.163433],
      updated_at: ~N[2018-05-01 21:33:32.163448]
    }
  end

  def fixture!(name) do
    name
    |> fixture()
    |> Repo.insert!
  end
end
