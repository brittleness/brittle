defmodule Brittle.Run do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.Suite
  require Ecto.Query

  schema "runs" do
    belongs_to(:suite, Suite)

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
    run
    |> cast(
      attributes,
      ~w(digest hostname branch revision dirty test_count failure_count
         excluded_count duration started_at finished_at)
    )
    |> put_assoc(:suite, suite(attributes.suite))
  end

  def suite(attributes) do
    case Suite
         |> Ecto.Query.where(name: ^attributes.name)
         |> Brittle.Repo.one() do
      %Suite{} = suite -> suite
      _ -> Suite.changeset(%Suite{}, attributes)
    end
  end
end
