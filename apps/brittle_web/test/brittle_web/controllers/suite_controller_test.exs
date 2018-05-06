defmodule Brittle.Web.SuiteControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  test "lists all suites", %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    [%{suite_id: phoenix_id}, %{suite_id: brittle_id}] = [
      fixture!(:run),
      fixture!(:run_brittle_ex_unit)
    ]

    conn = get(conn, "/")
    response = html_response(conn, 200)

    assert response =~ "Suites"
    assert response =~ ~s(<a href="/suites/#{phoenix_id}/runs">phoenix</a>)
    assert response =~ ~s(<a href="/suites/#{brittle_id}/runs">brittle_ex_unit</a>)
  end
end
