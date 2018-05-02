defmodule Brittle.Web.RunControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  test "GET /", %{conn: conn} do
    run = fixture!(:run)

    conn = get conn, "/suites/#{run.suite_id}/runs"
    response = html_response(conn, 200)

    assert response =~ "Runs for phoenix"
    assert response =~ "Alices-MBP.fritz.box"
    assert response =~ "master"
    assert response =~ ~s(<td><abbr title="df54993999a5b340c8d3949e526ae91dba09a351">df54993</abbr></td>)
    assert response =~ ~s(<td><time datetime="20.714 s">20.71 s</time></td>)
  end
end
