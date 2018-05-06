defmodule Brittle.Importer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Brittle.Importer.Supervisor]
    Supervisor.start_link(children(), opts)
  end

  def children do
    if Code.ensure_loaded?(Brittle.Importer.Watch) do
      [Brittle.Importer.Watch]
    else
      [Brittle.Importer.Poll]
    end
  end
end
