defmodule Brittle.Web.SuiteControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  setup %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    [%{suite_id: phoenix_id}, %{suite_id: brittle_id}] = [
      fixture!(:run),
      fixture!(:run_brittle_ex_unit)
    ]

    conn = get(conn, "/")
    [body: html_response(conn, 200), phoenix_id: phoenix_id, brittle_id: brittle_id]
  end


  test "lists all suites", %{body: body, phoenix_id: phoenix_id, brittle_id: brittle_id} do
    assert body =~ "Suites"
    assert body =~ ~s(<a href="/suites/#{phoenix_id}/runs">phoenix</a>)
    assert body =~ ~s(<a href="/suites/#{brittle_id}/runs">brittle_ex_unit</a>)
  end

  test "orders suites by their last run's finished_at", %{body: body} do
    assert Regex.scan(~r[phoenix|brittle_ex_unit], body) == [~w(brittle_ex_unit), ~w(phoenix)]
  end
end
