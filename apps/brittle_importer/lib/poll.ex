defmodule Brittle.Importer.Poll do
  use GenServer

  def start_link(_) do
    Mix.Tasks.Ecto.Migrate.run(~w(-r Brittle.Repo --quiet))
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send(self(), :work, [])

    {:ok, state}
  end

  def handle_info(:work, state) do
    Brittle.Importer.import!()
    Process.send_after(self(), :work, 10_000)

    {:noreply, state}
  end
end
