defmodule Brittle.Web.RunViewTest do
  use Brittle.Web.ConnCase, async: true
  alias Brittle.{Run, Web.RunView}

  test "short_revision/1 returns the short revision" do
    assert %Run{revision: "df54993999a5b340c8d3949e526ae91dba09a351"}
           |> RunView.short_revision() == "df54993"
  end

  test "human_duration/1 returns the duration in seconds" do
    assert %Run{duration: 20_713_727}
           |> RunView.human_duration() == "20.71 s"
  end

  test "human_duration/1 returns the duration in milliseconds" do
    assert %Run{duration: 713_727}
           |> RunView.human_duration() == "713.73 ms"
  end

  test "human_duration/1 returns the duration in microseconds" do
    assert %Run{duration: 727}
           |> RunView.human_duration() == "727 μs"
  end

  test "duration_time_component/1 returns a valid duration time component" do
    # As described in https://www.w3.org/TR/2014/REC-html5-20141028/infrastructure.html#duration-time-component
    assert %Run{duration: 20_713_727}
           |> RunView.duration_time_component() == "20.714 s"
  end

  test "status_icon/1 returns a check mark" do
    assert %Run{failure_count: 0} |> RunView.status_icon() == "✓"
  end

  test "status_icon/1 returns a cross" do
    assert %Run{failure_count: 1} |> RunView.status_icon() == "✗"
  end

  test "status/1 returns :passed with no failures" do
    assert %Run{failure_count: 0} |> RunView.status() == :passed
  end

  test "status/1 returns :failed with failures" do
    assert %Run{failure_count: 1} |> RunView.status() == :failed
  end

  test "duration_rate/2 returns 1 for the slowest test" do
    run = %Run{duration: 20_713_727}
    assert run |> RunView.duration_rate(run) == 1
  end

  test "duration_rate/2 returns 0.5 for a test twice as fast as the slowest" do
    run = %Run{duration: 20_713_728}
    assert run |> RunView.duration_rate(%Run{duration: 41_427_456}) == 0.5
  end
end
