defmodule Brittle.Web.RunController do
  require Ecto.Query
  use Brittle.Web, :controller
  alias Brittle.{Repo, Suite}

  def index(conn, %{"suite_id" => suite_id}) do
    suite = Suite
    |> Ecto.Query.preload(:runs)
    |> Repo.get(suite_id)

    render conn, "index.html", suite: suite
  end
end
