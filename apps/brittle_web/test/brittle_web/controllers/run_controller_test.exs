defmodule Brittle.Web.RunControllerTest do
  use Brittle.Web.ConnCase
  import Brittle.Fixtures

  setup %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)

    [run | _] = [fixture!(:run), fixture!(:failed_run)]
    conn = get(conn, "/suites/#{run.suite_id}/runs")

    [body: html_response(conn, 200), suite: run.suite, run: run]
  end

  test "shows the suite header", %{body: body} do
    assert body =~ ~s(<a href="/">Suites</a>)
    assert body =~ "<h1>phoenix</h1>"
    assert body =~ "<h2>Runs</h2>"
  end

  test "shows all runs for a suite", %{body: body, suite: %{id: suite_id}, run: %{id: run_id}} do
    assert body =~ ~s(<td class="status_icon">✓</td>)
    assert body =~ ~s(<a href="/suites/#{suite_id}/runs/#{run_id}/results"># #{run_id}</a>)
    assert body =~ "master"

    assert body =~
             ~s(<td><abbr title="df54993999a5b340c8d3949e526ae91dba09a351">df54993</abbr></td>)

    assert body =~ ~s(<td>617</td>)
    assert body =~ ~s(<td>4</td>)
    assert body =~ ~s(<td>0</td>)
    assert body =~ ~s(<time datetime="20.714 s">20.71 s</time>)

    assert body =~
             ~s(<td><time datetime="2018-05-01T21:33:32.163448Z">2018-05-01 21:33:32.163448Z</time></td>)
  end

  test "orders the runs by their finished_at dates, newest first", %{body: body} do
    assert Regex.scan(~r[✓|✗], body) == [~w(✗), ~w(✓)]
  end

  test "marks runs in dirty states as dirty", %{body: body} do
    assert body =~
             ~s(<td><abbr title="df54993999a5b340c8d3949e526ae91dba09a351">df54993</abbr> <small>(dirty\)</small></td>)
  end

  test "shows a duration bar for each run", %{body: body} do
    assert body =~ ~s(<span style="width: 76.67852347808208%"></span>)
  end
end
