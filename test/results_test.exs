defmodule Brittle.ResultsTest do
  use ExUnit.Case
  alias Brittle.{Results, Run}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)
  end

  test "create_run/1 creates a run" do
    assert {:ok, %Run{} = run} =
             Results.create_run(%{
               test_count: 3,
               failure_count: 1,
               excluded_count: 1,
               duration: 42
             })

    assert run.test_count == 3
    assert run.failure_count == 1
    assert run.excluded_count == 1
    assert run.duration == 42
  end
end
