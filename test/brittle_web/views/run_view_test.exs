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
end
