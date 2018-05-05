defmodule Brittle.Web.SuiteControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    fixture!(:suite)
    :ok
  end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    response = html_response(conn, 200)

    assert response =~ "Suites"
    assert response =~ "phoenix"
  end
end
