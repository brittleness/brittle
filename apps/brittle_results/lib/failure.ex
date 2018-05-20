defmodule Brittle.Failure do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.{Result}

  schema "failures" do
    belongs_to(:result, Result)

    field(:message, :string)
    field(:code, :string)
    field(:stacktrace, :string)

    timestamps()
  end

  def changeset(test, attributes) do
    cast(test, attributes, ~w(message code stacktrace))
  end
end
