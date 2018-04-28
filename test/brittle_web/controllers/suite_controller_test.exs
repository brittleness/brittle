defmodule Brittle.Web.SuiteControllerTest do
  use Brittle.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Suites"
  end
end
