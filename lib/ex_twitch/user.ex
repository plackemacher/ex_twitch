defmodule ExTwitch.User do
  @moduledoc false

  defstruct ~w(
    type name created_at updated_at logo _id display_name bio
  )a

  import ExTwitch
  alias ExTwitch.Client

  def user(client) do
    "user"
    |> get(Client.headers(client))
    |> parse_response(__MODULE__)
  end
  def user(client, username) when is_binary(username) do
    "users"
    |> get(Client.headers(client), params: %{login: username})
    |> parse_response
    |> case do
      {:ok, %{"_total": 1, "users": [user]}} ->
        {:ok, struct(__MODULE__, user)}
      {:ok, %{"_total": 0}} ->
        {:error, %ExTwitch.Error{message: "Unable to find user"}}
      other ->
        other
    end
  end
  def user(client, user_id) when is_integer(user_id) do
    "users/#{user_id}"
    |> get(Client.headers(client))
    |> parse_response(__MODULE__)
  end
end