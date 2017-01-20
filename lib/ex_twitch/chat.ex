defmodule ExTwitch.Chat do
  @moduledoc false

  import ExTwitch
  alias ExTwitch.Client
  alias ExTwitch.Badges

  def badges(client, channel_id) do
    "chat/#{channel_id}/badges"
    |> get(Client.headers(client))
    |> parse_response(Badges)
  end
end
