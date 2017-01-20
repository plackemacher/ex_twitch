defmodule ExTwitch do
  use HTTPoison.Base

  @api_version "v5"
  @accept_content_type "application/vnd.twitchtv.#{@api_version}+json"
  @endpoint "https://api.twitch.tv/kraken/"

  @moduledoc """
  Documentation for ExTwitch.
  """

  def process_url(url) do
    @endpoint <> url
  end

  def process_request_headers(headers) do
    headers ++ [{"Accept", @accept_content_type}]
  end

  def parse_response(response), do: parse_response(response, nil)
  def parse_response(response, as_type) when is_atom(as_type) and as_type != nil do
    parse_response(response, struct(as_type))
  end
  def parse_response(response, as_type) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body, as: as_type, keys: :atoms)}
      {:ok, %HTTPoison.Response{status_code: _, body: body}} ->
        {:error, Poison.decode!(body, as: %ExTwitch.Error{})}
      {:error, error} ->
        {:error, error}
    end
  end
end
