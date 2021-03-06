defmodule Brittle.Fixtures do
  alias Brittle.{Repo, Suite, Run}

  def attributes(:suite) do
    %{
      "name" => "phoenix"
    }
  end

  def attributes(:run) do
    %{
      "branch" => "master",
      "dirty" => false,
      "duration" => 20_713_727,
      "excluded_count" => 4,
      "failure_count" => 0,
      "hostname" => "Alices-MBP.fritz.box",
      "revision" => "df54993999a5b340c8d3949e526ae91dba09a351",
      "test_count" => 617,
      "suite" => attributes(:suite),
      "started_at" => ~N[2018-05-01 21:33:11.449706],
      "finished_at" => ~N[2018-05-01 21:33:32.163448],
      "results" => [
        attributes(:result),
        attributes(:failed_result),
        attributes(:slow_result)
      ]
    }
  end

  def attributes(:failed_run) do
    :run
    |> attributes()
    |> Map.merge(%{
      "duration" => 27_013_727,
      "dirty" => true,
      "failure_count" => 3,
      "started_at" => ~N[2018-05-05 09:00:38.910606],
      "finished_at" => ~N[2018-05-05 09:01:05.924333],
      "results" => [
        attributes(:failed_result)
      ]
    })
  end

  def attributes(:run_brittle_ex_unit) do
    :run
    |> attributes()
    |> Map.merge(%{
      "suite" => %{"name" => "brittle_ex_unit"},
      "started_at" => ~N[2018-05-05 09:00:38.910606],
      "finished_at" => ~N[2018-05-05 09:01:05.924333]
    })
  end

  def attributes(:result) do
    %{
      "duration" => 313_727,
      "status" => "passed",
      "test" => attributes(:test)
    }
  end

  def attributes(:failed_result) do
    %{
      "duration" => 6_313_727,
      "status" => "failed",
      "test" => attributes(:test),
      "failures" => [
        %{
          "message" => "Assertion with == failed",
          "code" => "assert true == false",
          "stacktrace" =>
            "    test/ex_unit_data_test.exs:30: ExampleTest.\"test fails\"/1\n"
        }
      ]
    }
  end

  def attributes(:slow_result) do
    %{
      "duration" => 20_313_727,
      "status" => "passed",
      "test" => attributes(:test)
    }
  end

  def attributes(:test) do
    %{
      "module" => "Elixir.ExampleTest",
      "name" => "test passes",
      "file" => "test/example_test.exs",
      "line" => 12
    }
  end

  def fixture(:suite) do
    Suite.changeset(%Suite{}, attributes(:suite))
  end

  def fixture(:run) do
    Run.changeset(%Run{}, attributes(:run))
  end

  def fixture(:failed_run) do
    Run.changeset(%Run{}, attributes(:failed_run))
  end

  def fixture(:run_brittle_ex_unit) do
    Run.changeset(%Run{}, attributes(:run_brittle_ex_unit))
  end

  def fixture!(name) do
    name
    |> fixture()
    |> Repo.insert!
  end
end
