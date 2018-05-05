defmodule Brittle.Importer do
  def import! do
    Application.get_env(
      :brittle_importer,
      :payload_directory,
      Path.join(System.user_home!(), "brittle/payloads")
    )
    |> Path.join("*.json")
    |> Path.wildcard
    |> Enum.each(fn(payload) ->
      payload
      |> File.read!
      |> Jason.decode!(keys: :atoms!)
      |> Brittle.Results.create_run
    end)
  end
end
