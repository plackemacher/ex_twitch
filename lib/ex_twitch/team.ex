defmodule ExTwitch.Team do
  import ExTwitch
  alias ExTwitch.{Client, Channel}

  defstruct ~w(_id background banner created_at display_name info logo name updated_at users)a

  @type t :: %__MODULE__{_id: integer, background: binary, banner: binary, created_at: binary,
    display_name: binary, info: binary, logo: binary, name: binary, updated_at: binary,
    users: [Channel.t]
  }

  @spec team(binary, Client.t) :: {term, t}
  def team(name, client) do
    "teams/#{name}"
    |> get(client)
    |> parse_response(%__MODULE__{"users": [%Channel{}]})
  end
end
