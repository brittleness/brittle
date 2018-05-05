defmodule Brittle.Fixtures do
  alias Brittle.{Repo, Suite, Run}

  def attributes(:suite) do
    %{
      name: "phoenix",
      inserted_at: ~N[2018-05-01 21:32:21.097299],
      updated_at: ~N[2018-05-01 21:32:21.097312]
    }
  end

  def attributes(:run) do
  %{
    branch: "master",
    digest: "5e40eb035846ae6e762cbd22e65c34f3",
    dirty: true,
    duration: 20713727,
    excluded_count: 4,
    failure_count: 0,
    hostname: "Alices-MBP.fritz.box",
    revision: "df54993999a5b340c8d3949e526ae91dba09a351",
    test_count: 617,
    suite: attributes(:suite),
    started_at: ~N[2018-05-01 21:33:11.449706],
    finished_at: ~N[2018-05-01 21:33:32.163448],
    inserted_at: ~N[2018-05-01 21:33:32.163433],
    updated_at: ~N[2018-05-01 21:33:32.163448]
  }
  end

  def fixture(:suite) do
    Suite.changeset(%Suite{}, attributes(:suite))
  end

  def fixture(:run) do
    Run.changeset(%Run{}, attributes(:run))
  end

  def fixture!(name) do
    name
    |> fixture()
    |> Repo.insert!
  end
end
