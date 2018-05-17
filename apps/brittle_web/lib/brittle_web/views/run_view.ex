defmodule Brittle.Web.RunView do
  use Brittle.Web, :view
  alias Brittle.{Run, Test}

  def short_revision(%Run{revision: revision}) do
    String.slice(revision, 0..6)
  end

  def status_icon(%Run{} = run) do
    run
    |> status()
    |> Atom.to_string()
    |> status_icon()
  end

  def status_icon("passed"), do: "✓"
  def status_icon("failed"), do: "✗"

  def status(%Run{failure_count: 0}), do: :passed
  def status(%Run{failure_count: _}), do: :failed

  def file_and_line(%Test{file: file, line: line}) do
    word_break("#{file}:#{line}", "/")
  end

  def module(%Test{module: module}) do
    word_break(module, ".")
  end

  defp word_break({:safe, data}, break_character) when is_binary(data) do
    {:safe, word_break(data, break_character, "")}
  end

  defp word_break({:safe, data}, break_character) do
    {:safe, word_break(IO.iodata_to_binary(data), break_character, "")}
  end

  defp word_break(unsafe, break_character) do
    unsafe
    |> html_escape
    |> word_break(break_character)
  end

  defp word_break(<<"&lt;/", t::binary>>, "/", acc) do
    word_break(t, "/", <<acc::binary, "&lt;/">>)
  end

  defp word_break(<<"/", t::binary>>, "/", acc) do
    word_break(t, "/", <<acc::binary, "/<wbr>">>)
  end

  defp word_break(<<".", t::binary>>, ".", acc) do
    word_break(t, ".", <<acc::binary, ".<wbr>">>)
  end

  defp word_break(<<h, t::binary>>, replace, acc) do
    word_break(t, replace, <<acc::binary, h>>)
  end

  defp word_break(<<>>, _, acc), do: acc
end
