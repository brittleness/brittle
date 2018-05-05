defmodule Brittle.Suite do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.Run

  schema "suites" do
    has_many(:runs, Run)

    field(:name, :string)

    timestamps()
  end

  def changeset(suite, attributes) do
    cast(suite, attributes, ~w(name))
  end
end
