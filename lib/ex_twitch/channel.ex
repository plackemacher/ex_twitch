defmodule ExTwitch.Channel do
  @moduledoc false

  defstruct ~w(_id broadcaster_language created_at display_name
    followers game language logo mature name partner profile_banner
    profile_banner_background_color status updated_at url video_banner
    views
  )a

  import ExTwitch
  alias ExTwitch.Client

  def channel(client) do
    "channel"
    |> get(Client.headers(client))
    |> parse_response(__MODULE__)
  end

  def channel(client, channel_id) do
    "channels/#{channel_id}"
    |> get(Client.headers(client))
    |> parse_response(__MODULE__)
  end

  def update_channel(client, channel_id, options) do
    "channels/#{channel_id}"
    |> put(Poison.encode!(options), Client.headers(client))
    |> parse_response(__MODULE__)
  end
end