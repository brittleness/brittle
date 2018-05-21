defmodule Brittle.Results do
  alias Brittle.{Repo, Run}

  def create_run(attributes \\ %{}) do
    digest = digest(attributes)

    case Repo.get_by(Run, digest: digest) do
      %Run{} = run ->
        {:ok, run}

      _ ->
        attributes = Map.put(attributes, "digest", digest)

        %Run{}
        |> Run.changeset(attributes)
        |> Repo.insert()
    end
  end

  defp digest(attributes) do
    :md5
    |> :crypto.hash(Jason.encode!(attributes))
    |> Base.encode16(case: :lower)
  end
end
