defmodule Brittle.Web.SuiteController do
  use Brittle.Web, :controller
  alias Brittle.{Repo, Suite}
  require Ecto.Query

  def index(conn, _params) do
    suites =
      Suite
      |> Ecto.Query.join(:left, [s], assoc(s, :runs))
      |> Ecto.Query.group_by([s], s.id)
      |> Ecto.Query.order_by([s, r], desc: max(r.finished_at))
      |> Repo.all()

    render(conn, "index.html", suites: suites)
  end
end
