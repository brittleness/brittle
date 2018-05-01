defmodule Brittle.Suite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suites" do
    field(:name, :string)

    timestamps()
  end

  def changeset(suite, attributes) do
    cast(suite, attributes, ~w(name))
  end
end
