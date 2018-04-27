defmodule Brittle.Results.ApplicationTest do
  use ExUnit.Case

  test "start/2 falls back to the default configuration" do
    config = Application.fetch_env!(:brittle_results, Brittle.Repo)
    Application.delete_env(:brittle_results, Brittle.Repo)

    Brittle.Results.Application.start(:normal, [])

    assert Application.fetch_env!(:brittle_results, Brittle.Repo) == [
             adapter: Sqlite.Ecto2,
             database: "brittle.sqlite3"
           ]

    Application.put_env(:brittle_results, Brittle.Repo, config)
  end

  test "start/2 does not overwrite existing configuration" do
    [brittle_results: [{Brittle.Repo, config} | _]] = Mix.Config.read!("config/config.exs")

    assert Application.fetch_env!(:brittle_results, Brittle.Repo) == config
  end
end
