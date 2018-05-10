defmodule Brittle.ResultsTest do
  use ExUnit.Case, async: true
  alias Brittle.{Repo, Results, Suite, Run, Result, Test}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    [
      attributes: %{
        hostname: "Alices-MBP.fritz.box",
        branch: "develop",
        revision: "db017e7f18b35d69a2b4305efc0f002bb3675669",
        dirty: true,
        test_count: 3,
        failure_count: 1,
        excluded_count: 1,
        duration: 42,
        suite: %{name: "brittle_ex_unit"},
        started_at: DateTime.from_naive!(~N[2018-05-04 20:44:19.652251], "Etc/UTC"),
        finished_at: DateTime.from_naive!(~N[2018-05-04 20:44:19.721502], "Etc/UTC"),
        results: [
          %{
            status: "passed",
            duration: 42,
            test: %{module: "Elixir.ExampleTest", name: "test passes"}
          }
        ]
      }
    ]
  end

  test "create_run/1 creates a run", %{attributes: attributes} do
    {:ok, %Run{} = run} = Results.create_run(attributes)

    assert run.hostname == "Alices-MBP.fritz.box"
    assert run.branch == "develop"
    assert run.revision == "db017e7f18b35d69a2b4305efc0f002bb3675669"
    assert run.dirty == true
    assert run.test_count == 3
    assert run.failure_count == 1
    assert run.excluded_count == 1
    assert run.duration == 42
    assert run.started_at == DateTime.from_naive!(~N[2018-05-04 20:44:19.652251], "Etc/UTC")
    assert run.finished_at == DateTime.from_naive!(~N[2018-05-04 20:44:19.721502], "Etc/UTC")
  end

  test "create_run/1 does not create the same run twice", %{attributes: attributes} do
    assert {:ok, %Run{id: id}} = Results.create_run(attributes)
    assert {:ok, %Run{id: ^id}} = Results.create_run(attributes)
  end

  test "create_run/1 creates a suite", %{attributes: attributes} do
    {:ok, %Run{suite: %Suite{} = suite}} = Results.create_run(attributes)

    assert suite.name == "brittle_ex_unit"
  end

  test "create_run/1 links runs to existing suites", %{attributes: attributes} do
    %Suite{id: id} = Repo.insert!(%Suite{name: "brittle_ex_unit"})

    assert {:ok, %Run{suite_id: ^id}} = Results.create_run(attributes)
  end

  test "create_run/1 creates a result", %{attributes: attributes} do
    {:ok, %Run{results: [%Result{} = result]}} = Results.create_run(attributes)

    assert result.status == "passed"
    assert result.duration == 42
  end

  test "create_run/1 creates a test", %{attributes: attributes} do
    {:ok, %Run{results: [%Result{test: %Test{} = test}]}} = Results.create_run(attributes)

    assert test.module == "Elixir.ExampleTest"
    assert test.name == "test passes"
  end
end
