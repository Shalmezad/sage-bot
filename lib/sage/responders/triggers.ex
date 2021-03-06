defmodule Sage.Responders.Triggers do
  @moduledoc """
  A map of triggers to respond to.

  Keep the keys in this module lowercase and with no whitespace.

  However, usage is case-insensitive.

  ### Examples

      User> !hello
      sage> Hi there!

      User> !NO
      sage> Noooo! https://www.youtube.com/watch?v=umDr0mPuyQc

  """

  use Sage.Responder

  @triggers %{
    "hello" => "Hi there!",
    "goodbye" => "See ya!",
    "no" => "Noooo! https://www.youtube.com/watch?v=umDr0mPuyQc",
    "nope" => "https://media.giphy.com/media/6h4z4b3v6XWxO/giphy.gif",
    "colors" => "#003057,#4986AD,#C69214,#FFFFFF,#4986AD,#FFFFFF,#509E2F,#862633",
    "git" => "https://github.com/wgu-it/sage-bot",
    "contributing" => "To help me get better you can *fork* https://github.com/wgu-it/sage-bot, *commit* your changes, and then make a *pull request*!",
    "googledrive" => "Repo with eBooks and More! Sign up with your @wgu.edu email address. https://drive.google.com/folderview?id=0B1S7OJNChk1-cWhwNWZTb2JNY1E",
    "ugt" => "UGT (abbr.): Universal Greeting Time.\n_UGT_ is a convention that states that it is always morning when person comes into a channel, and it is always late night when person leaves. Local time of any member of channel is irrelevant.",
    "y" => "http://i.imgur.com/yZRYrIF.jpg",
    "bcuz" => "http://i.imgur.com/j6nbopM.png",
  }

  @trigger_matches Map.keys(@triggers) |> Enum.join("|")

  @trigger_char Config.get_env(:sage, :trigger_char, "!")

  # Respond with one of the trigger responses... ᕕ( ᐛ )ᕗ
  hear ~r/^#{@trigger_char}(#{@trigger_matches})$/i, msg do
    send msg, Map.get(@triggers, sanitize(msg.matches[1]))
  end

  @usage """
  `hedwig list triggers` - Respond with a list of available triggers
  """
  respond ~r/list triggers/, msg do
    send msg,
      @triggers
      |> Map.keys()
      |> Enum.map(fn trigger -> "`#{@trigger_char}#{trigger}`" end)
      |> Enum.join(", ")
  end

  # Sanitize the input
  defp sanitize(match) do
    match
    |> String.downcase()
  end
end
