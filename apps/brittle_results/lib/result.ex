defmodule Brittle.Result do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.{Run, Test}

  schema "results" do
    belongs_to(:run, Run)
    belongs_to(:test, Test)

    field(:status, :string)

    timestamps()
  end

  def changeset(result, attributes) do
    result
    |> cast(attributes, ~w(status))
    |> cast_assoc(:test)
  end
end
