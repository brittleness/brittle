defmodule Brittle.Fixtures do
  alias Brittle.{Repo, Suite}

  def fixture(:suite) do
    %Suite{
      name: "phoenix",
      inserted_at: ~N[2018-05-01 21:32:21.097299],
      updated_at: ~N[2018-05-01 21:32:21.097312]
    }
  end

  def fixture!(name) do
    name
    |> fixture()
    |> Repo.insert!
  end
end
