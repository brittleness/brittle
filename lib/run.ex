defmodule Brittle.Run do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.Suite

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

    timestamps()
  end

  def changeset(run, attributes) do
    run
    |> cast(
      attributes,
      ~w(digest hostname branch revision dirty test_count failure_count excluded_count duration)
    )
    |> cast_assoc(:suite)
  end
end
