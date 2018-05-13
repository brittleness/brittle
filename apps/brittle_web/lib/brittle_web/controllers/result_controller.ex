defmodule Brittle.Web.ResultController do
  require Ecto.Query
  use Brittle.Web, :controller
  alias Brittle.{Repo, Run, Result}

  def index(conn, %{"run_id" => id}) do
    result_query =
      Result
      |> Ecto.Query.preload(:test)
      |> Ecto.Query.order_by(:status)

    run =
      Run
      |> Ecto.Query.preload(:suite)
      |> Ecto.Query.preload(results: ^result_query)
      |> Repo.get(id)

    render(conn, "index.html", suite: run.suite, run: run)
  end
end
