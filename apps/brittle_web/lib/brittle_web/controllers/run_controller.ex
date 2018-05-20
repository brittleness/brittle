defmodule Brittle.Web.RunController do
  require Ecto.Query
  use Brittle.Web, :controller
  alias Brittle.{Repo, Results, Suite, Run, Result}

  def index(conn, %{"suite_id" => suite_id}) do
    run_query = Ecto.Query.order_by(Run, desc: :inserted_at)

    suite = %Suite{runs: runs} = Suite
    |> Ecto.Query.preload(runs: ^run_query)
    |> Repo.get(suite_id)

    slowest = Enum.max_by(runs, fn(run) -> run.duration end)

    render conn, "index.html", suite: suite, runs: runs, slowest: slowest
  end

  def show(conn, %{"id" => id}) do
    result_query =
      Result
      |> Ecto.Query.preload([:test, :failures])
      |> Ecto.Query.order_by([asc: :status, desc: :duration])

    run =
      Run
      |> Ecto.Query.preload(:suite)
      |> Ecto.Query.preload(results: ^result_query)
      |> Repo.get(id)

    render(conn, "show.html", suite: run.suite, run: run)
  end

  def create(conn, payload) do
    {:ok, %Run{}} = Results.create_run(payload)
    send_resp(conn, 201, "")
  end
end
