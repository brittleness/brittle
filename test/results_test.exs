defmodule Brittle.ResultsTest do
  use ExUnit.Case
  alias Brittle.{Results, Run}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    [
      attributes: %{
        hostname: "Alices-MBP.fritz.box",
        test_count: 3,
        failure_count: 1,
        excluded_count: 1,
        duration: 42
      }
    ]
  end

  test "create_run/1 creates a run", %{attributes: attributes} do
    assert {:ok, %Run{} = run} = Results.create_run(attributes)

    assert run.hostname == "Alices-MBP.fritz.box"
    assert run.test_count == 3
    assert run.failure_count == 1
    assert run.excluded_count == 1
    assert run.duration == 42
  end

  test "create_run/1 does not create the same run twice", %{attributes: attributes} do
    assert {:ok, %Run{} = run} = Results.create_run(attributes)
    assert {:ok, %Run{} = ^run} = Results.create_run(attributes)
  end
end
