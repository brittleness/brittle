defmodule Brittle.Results do
  alias Brittle.{Repo, Run}

  def create_run(attributes \\ %{}) do
    %Run{}
    |> Run.changeset(attributes)
    |> Repo.insert()
  end
end
