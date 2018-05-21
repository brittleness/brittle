defmodule Brittle.Run do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.{Repo, Suite, Result}
  require Ecto.Query

  schema "runs" do
    belongs_to(:suite, Suite)
    has_many(:results, Result)

    field(:digest, :string)
    field(:hostname, :string)
    field(:branch, :string)
    field(:dirty, :boolean)
    field(:revision, :string)
    field(:test_count, :integer)
    field(:failure_count, :integer)
    field(:excluded_count, :integer)
    field(:duration, :integer)
    field(:started_at, :utc_datetime)
    field(:finished_at, :utc_datetime)

    timestamps()
  end

  def changeset(run, attributes) do
    suite = suite(attributes["suite"])
    attributes = inject_suite_into_tests(attributes, suite)

    run
    |> cast(
      attributes,
      ~w(digest hostname branch revision dirty test_count failure_count
excluded_count duration started_at finished_at)
    )
    |> put_assoc(:suite, suite)
    |> cast_assoc(:results)
  end

  def suite(attributes) do
    case Suite
         |> Ecto.Query.where(name: ^attributes["name"])
         |> Brittle.Repo.one() do
      %Suite{} = suite ->
        suite

      _ ->
        %Suite{}
        |> Suite.changeset(attributes)
        |> Repo.insert!()
    end
  end

  defp inject_suite_into_tests(attributes, suite) do
    results =
      Enum.map(attributes["results"], fn result ->
        {_, test} =
          Map.get_and_update(result, "test", fn test ->
            {test, Map.put(test, "suite_id", suite.id)}
          end)

        test
      end)

    %{attributes | "results" => results}
  end
end
