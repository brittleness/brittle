defmodule Brittle.Web.RunController do
  require Ecto.Query
  use Brittle.Web, :controller
  alias Brittle.{Repo, Suite, Run}

  def index(conn, %{"suite_id" => suite_id}) do
    run_query = Ecto.Query.order_by(Run, desc: :inserted_at)

    suite = %Suite{runs: runs} = Suite
    |> Ecto.Query.preload(runs: ^run_query)
    |> Repo.get(suite_id)

    slowest = Enum.max_by(runs, fn(run) -> run.duration end)

    render conn, "index.html", suite: suite, runs: runs, slowest: slowest
  end
end
