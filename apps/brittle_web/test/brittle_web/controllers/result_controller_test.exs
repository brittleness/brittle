defmodule Brittle.Web.ResultControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  setup %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    [run | _] = [fixture!(:run), fixture!(:failed_run)]
    conn = get(conn, "/suites/#{run.suite_id}/runs/#{run.id}/results")

    [body: html_response(conn, 200), run: run]
  end

  test "shows the suite header", %{body: body, run: %{id: run_id, suite_id: suite_id}} do
    assert body =~ ~s(<a href="/">Suites</a>)
    assert body =~ ~s(<h1><a href="/suites/#{suite_id}/runs">phoenix</a></h1>)
    assert body =~ "<h2>Run ##{run_id}</h2>"
  end

  test "shows all results for a run", %{body: body} do
    assert body =~ ~s(<td class="status_icon">✓</td>)
    assert body =~ ~s(<td>Elixir.ExampleTest</td>)
    assert body =~ ~s(<td>test passes</td>)
    assert body =~ ~s(<time datetime="20.314 s">20.31 s</time>)
    assert body =~ ~s(<small>(98.07 %\)</small>)
  end

  test "orders the results by their statuses, failures first", %{body: body} do
    assert Regex.scan(~r[✓|✗], body) == [~w(✗), ~w(✓), ~w(✓)]
  end

  test "after statuses, orders results by their durations, slowest first", %{body: body} do
    assert Regex.scan(~r[\d+.\d{3} s], body) == [["6.314 s"], ["20.314 s"], ["0.314 s"]]
  end

  test "shows a duration bar for each result", %{body: body} do
    assert body =~ ~s(<span style="width: 98.06891343117537%"></span>)
  end
end
