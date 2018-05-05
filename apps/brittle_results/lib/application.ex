defmodule Brittle.Results.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  @system Application.get_env(:brittle_results, :system, System)

  use Application

  def start(_type, _args) do
    case Application.fetch_env(:brittle_results, Brittle.Repo) do
      :error ->
        Application.put_env(
          :brittle_results,
          Brittle.Repo,
          adapter: Sqlite.Ecto2,
          database: "#{@system.user_home!()}/brittle/brittle.sqlite3"
        )

      _ ->
        :ok
    end

    # List all child processes to be supervised
    children = [
      Brittle.Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BrittleResults.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
