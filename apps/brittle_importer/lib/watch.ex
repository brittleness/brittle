if Code.ensure_loaded?(FileSystem) do
  defmodule Brittle.Importer.Watch do
    use GenServer
    alias Brittle.Importer

    def start_link(_) do
      Mix.Tasks.Ecto.Migrate.run(~w(-r Brittle.Repo --quiet))
      GenServer.start_link(__MODULE__, %{})
    end

    def init(state) do
      {:ok, pid} = FileSystem.start_link(dirs: [Importer.payload_directory()])
      FileSystem.subscribe(pid)

      Process.send(self(), {:file_event, nil, nil}, [])

      {:ok, state}
    end

    def handle_info({:file_event, _, _}, state) do
      Brittle.Importer.import!()

      {:noreply, state}
    end
  end
end
