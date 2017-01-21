defmodule ExTwitch.User do
  import ExTwitch
  alias ExTwitch.{Client, Follow, Channel}

  defstruct ~w(
    type name created_at updated_at logo _id display_name bio
  )a

  @type t :: %__MODULE__{type: binary, name: binary, created_at: binary, updated_at: binary,
    logo: binary, _id: binary, display_name: binary, bio: binary
  }

  @spec me(Client.t) :: {:ok, t} | {:error, ExTwitch.error}
  def me(client) do
    "user"
    |> get(client)
    |> parse_response(__MODULE__)
  end

  def user(_, client \\ %Client{})

  @spec user(binary, Client.t) :: {:ok, t} | {:error, ExTwitch.error}
  def user(username, client) when is_binary(username) do
    "users"
    |> get(client, params: [login: username])
    |> parse_response
    |> case do
      {:ok, %{"_total": 1, "users": [user]}} ->
        {:ok, struct(__MODULE__, user)}
      {:ok, %{"_total": 0}} ->
        {:error, %ExTwitch.Error{message: "Unable to find user", status: 404}}
      other ->
        other
    end
  end

  @spec user(integer, Client.t) :: {:ok, t} | {:error, ExTwitch.error}
  def user(user_id, client) when is_integer(user_id) do
    "users/#{user_id}"
    |> get(client)
    |> parse_response(__MODULE__)
  end

  @spec emotes(integer, Client.t) :: {:ok, map} | {:error, ExTwitch.error}
  def emotes(user_id, client \\ %Client{}) do
    case "users/#{user_id}/emotes"
         |> get(client)
         |> parse_response do
       {:ok, response} -> {:ok, Map.get(response, :emoticon_sets)}
       other -> other
     end
  end

  @spec subscribed?(integer, integer, Client.t) :: {:ok, boolean} | {:error, ExTwitch.error}
  def subscribed?(user_id, channel_id, client \\ %Client{}) do
    case "users/#{user_id}/subscriptions/#{channel_id}"
         |> get(client)
         |> parse_response do
      {:ok, _response} -> {:ok, true}
      {:error, %ExTwitch.Error{status: 404}} -> {:ok, false}
      {:error, error} -> {:error, error}
    end
  end

  @spec user_follows(integer, list, Client.t) :: {:ok, any} | {:error, ExTwitch.error}
  def user_follows(user_id, options \\ [], client \\ %Client{}) do
    "users/#{user_id}/follows/channels"
    |> get_paged(client, [params: options], :follows, %{follows: [%Follow{channel: %Channel{}}]})
  end
end
