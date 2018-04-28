defmodule Brittle.Run do
  use Ecto.Schema
  import Ecto.Changeset

  schema "runs" do
    field(:digest, :string)
    field(:suite, :string)
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
    cast(
      run,
      attributes,
      ~w(digest suite hostname branch revision dirty test_count failure_count excluded_count duration)
    )
  end
end
