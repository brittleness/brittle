defmodule Brittle.Web.SuiteControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  test "lists all suites", %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    %{id: id} = fixture!(:suite)
    conn = get conn, "/"
    response = html_response(conn, 200)

    assert response =~ "Suites"
    assert response =~ ~s(<a href="/suites/#{id}/runs">phoenix</a>)
  end
end
