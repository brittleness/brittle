defmodule Brittle.Web.RunViewTest do
  use Brittle.Web.ConnCase, async: true
  alias Brittle.{Run, Web.RunView}

  test "short_revision/1 returns the short revision" do
    assert %Run{revision: "df54993999a5b340c8d3949e526ae91dba09a351"}
           |> RunView.short_revision() == "df54993"
  end

  test "status_icon/1 returns a check mark for a passing run" do
    assert RunView.status_icon(%Run{failure_count: 0}) == "✓"
  end

  test "status_icon/1 returns a cross for a failing run" do
    assert RunView.status_icon(%Run{failure_count: 1}) == "✗"
  end

  test "status_icon/1 returns a check mark for 'passed'" do
    assert RunView.status_icon("passed") == "✓"
  end

  test "status_icon/1 returns a cross for 'failed'" do
    assert RunView.status_icon("failed") == "✗"
  end

  test "status/1 returns :passed with no failures" do
    assert %Run{failure_count: 0} |> RunView.status() == :passed
  end

  test "status/1 returns :failed with failures" do
    assert %Run{failure_count: 1} |> RunView.status() == :failed
  end
end
