defmodule Brittle.Web.RunViewTest do
  use Brittle.Web.ConnCase, async: true
  alias Brittle.{Run, Test, Web.RunView}

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

  test "file_and_line/1 returns the test file and line, with word breaks" do
    assert RunView.file_and_line(%Test{file: "path/to/file.ex", line: 12}) ==
             {:safe, "path/<wbr>to/<wbr>file.ex:12"}
  end

  test "file_and_line/1 escapes HTML" do
    assert RunView.file_and_line(%Test{
             file: "path/to/<strong>file</strong>.ex",
             line: 13
           }) ==
             {:safe,
              "path/<wbr>to/<wbr>&lt;strong&gt;file&lt;/strong&gt;.ex:13"}
  end

  test "module/1 returns the test module, with word breaks" do
    assert RunView.module(%Test{module: "Elixir.TestExample"}) ==
             {:safe, "Elixir.<wbr>TestExample"}
  end

  test "module/1 escapes HTML" do
    assert RunView.module(%Test{module: "Elixir.<strong>TestExample</strong>"}) ==
             {:safe, "Elixir.<wbr>&lt;strong&gt;TestExample&lt;/strong&gt;"}
  end
end
