defmodule Brittle.Result do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.{Run, Test}

  schema "results" do
    belongs_to(:run, Run)
    belongs_to(:test, Test)

    timestamps()
  end

  def changeset(result, attributes) do
    result
    |> cast(attributes, [])
    |> cast_assoc(:test)
  end
end
