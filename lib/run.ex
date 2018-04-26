defmodule Brittle.Run do
  use Ecto.Schema
  import Ecto.Changeset

  schema "runs" do
    field(:test_count, :integer)
    field(:failure_count, :integer)
    field(:duration, :integer)

    timestamps()
  end

  def changeset(run, attributes) do
    cast(run, attributes, ~w(test_count failure_count duration))
  end
end
