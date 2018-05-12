defmodule Brittle.Web.ResultControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  setup %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    [run | _] = [fixture!(:run), fixture!(:failed_run)]
    conn = get(conn, "/suites/#{run.suite_id}/runs/#{run.id}/results")

    [body: html_response(conn, 200), run: run]
  end

  test "shows the suite header", %{body: body, run: %{id: id}} do
    assert body =~ ~s(<a href="/">Suites</a>)
    assert body =~ "<h1>phoenix</h1>"
    assert body =~ "<h2>Run ##{id}</h2>"
  end

  test "shows all results for a run", %{body: body} do
    assert body =~ ~s(<td class="status_icon">✓</td>)
    assert body =~ ~s(<td>Elixir.ExampleTest</td>)
    assert body =~ ~s(<td>test passes</td>)
    assert body =~ ~s(<time datetime="20.714 s">20.71 s</time>)
    assert body =~ ~s(<small>(100.0 %\)</small>)
  end
end
