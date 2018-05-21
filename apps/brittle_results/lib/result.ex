defmodule Brittle.Result do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.{Repo, Run, Test, Failure}
  require Ecto.Query

  schema "results" do
    belongs_to(:run, Run)
    belongs_to(:test, Test)
    has_many(:failures, Failure)

    field(:status, :string)
    field(:duration, :integer)

    timestamps()
  end

  def changeset(result, attributes) do
    result
    |> cast(attributes, ~w(status duration))
    |> put_assoc(:test, test(attributes["test"]))
    |> cast_assoc(:failures)
  end

  defp test(attributes) do
    case Test
         |> Ecto.Query.where(
           module: ^attributes["module"],
           name: ^attributes["name"]
         )
         |> Brittle.Repo.one() do
      %Test{} = test ->
        test

      _ ->
        %Test{}
        |> Test.changeset(attributes)
        |> Repo.insert!()
    end
  end
end
