defmodule Brittle.Web.ResultController do
  require Ecto.Query
  use Brittle.Web, :controller
  alias Brittle.{Repo, Suite, Run}

  def index(conn, %{"run_id" => id}) do
    run = Run
    |> Ecto.Query.preload(:suite)
    |> Repo.get(id)

    render conn, "index.html", suite: run.suite, run: run
  end
end
