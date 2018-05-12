defmodule Brittle.Web.ResultViewTest do
  use Brittle.Web.ConnCase, async: true
  alias Brittle.Web.ResultView

  test "status_icon/1 returns a check mark" do
    assert ResultView.status_icon("passed") == "✓"
  end

  test "status_icon/1 returns a cross" do
    assert ResultView.status_icon("failed") == "✗"
  end
end
