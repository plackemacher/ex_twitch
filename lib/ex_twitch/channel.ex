defmodule ExTwitch.Channel do
  import ExTwitch
  alias ExTwitch.Client

  defstruct [:_id, :broadcaster_language, :created_at, :display_name,
    :followers, :game, :language, :logo, :mature, :name, :partner, :profile_banner,
    :profile_banner_background_color, :status, :updated_at, :url, :video_banner,
    :views
  ]

  @type t :: %__MODULE__{_id: integer, broadcaster_language: binary, created_at: binary, display_name: binary,
    followers: binary, game: binary, language: binary, logo: binary, mature: boolean, name: binary, partner: boolean,
    profile_banner: binary, profile_banner_background_color: binary, status: binary, updated_at: binary, url: binary,
    video_banner: binary, views: integer
  }


  @spec channel(Client.t) :: {term, t}
  def channel(%Client{} = client) do
    "channel"
    |> get(client)
    |> parse_response(__MODULE__)
  end

  @spec channel(integer, Client.t) :: {term, t}
  def channel(channel_id, client \\ %Client{}) do
    "channels/#{channel_id}"
    |> get(client)
    |> parse_response(__MODULE__)
  end

  @spec update_channel(integer, map, Client.t) :: {term, t}
  def update_channel(channel_id, options, client) do
    "channels/#{channel_id}"
    |> put(Poison.encode!(options), client)
    |> parse_response(__MODULE__)
  end
end
