defmodule ExTwitch.Chat do
  import ExTwitch
  alias ExTwitch.{Client, Badges}

  @spec badges(integer, Client.t) :: {term, Badges.t}
  def badges(channel_id, client \\ %Client{}) do
    "chat/#{channel_id}/badges"
    |> get(client)
    |> parse_response(Badges)
  end
end
