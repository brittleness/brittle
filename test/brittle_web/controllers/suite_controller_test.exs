defmodule Brittle.Web.SuiteControllerTest do
  use Brittle.Web.ConnCase
  alias Brittle.{Repo, Suite}

  setup do
    Repo.insert!(%Suite{name: "brittle_web"})
    :ok
  end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    response = html_response(conn, 200)

    assert response =~ "Suites"
    assert response =~ "brittle_web"
  end
end
