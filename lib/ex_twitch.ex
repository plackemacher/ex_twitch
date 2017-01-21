defmodule ExTwitch do
  use HTTPoison.Base
  alias ExTwitch.Client

  @api_version "v5"
  @endpoint "https://api.twitch.tv/kraken/"
  @package_version Mix.Project.config[:version]
  @user_agent {"User-agent", "ExTwitch/#{@package_version}"}
  @accept_content_type {"Accept", "application/vnd.twitchtv.#{@api_version}+json"}

  @type error :: ExTwitch.Error.t | HTTPoison.Error.t

  @moduledoc """
  Documentation for ExTwitch.
  """

  @spec process_url(binary) :: binary
  def process_url(url) do
    @endpoint <> url
  end

  @spec process_request_headers([{binary, term}]) :: [{binary, term}]
  def process_request_headers(headers) do
    [
      @user_agent,
      @accept_content_type,
      {"Client-ID", client_id()}
    ] ++ headers
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

  def post(path, client, body \\ "") do
    :post
    |> _request(path, body, client_headers(client))
  end

  def patch(path, client, body \\ "") do
    :patch
    |> _request(path, body, client_headers(client))
  end

  def put(path, client, body \\ "") do
    :put
    |> _request(path, body, client_headers(client))
  end

  def delete(path, client, body \\ "") do
    :delete
    |> _request(path, body, client_headers(client))
  end

  def get(path, client, options \\ []) do
    :get
    |> _request(path, "", client_headers(client), options)
  end

  def get_paged(path, client, options \\ [], list_atom, parse_type) do
    response = :get
               |> _request(path, "", client_headers(client), options)
               |> parse_response(parse_type)

    case response do
      {:ok, data} ->
        items = Map.get(data, list_atom)

        case pagination_method(data) do
          :pagination ->
            total = data._total
            last_offset = (Keyword.get(options, :params, [offset: 0]) |> Keyword.get(:offset, 0)) + 25
            if last_offset >= total do
              items
            else
              params = Keyword.get(options, :params) |> Keyword.merge([offset: last_offset])
              get_paged(path, client, Keyword.merge(options, [params: params]), list_atom, parse_type) ++ items
            end
          :cursor ->
            cursor = data._cursor
            params = Keyword.get(options, :params) |> Keyword.merge([cursor: cursor])
            get_paged(path, client, Keyword.merge(options, [params: params]), list_atom, parse_type) ++ items
        end
      other -> other
    end
  end

  defp _request(method, path, body, headers, options \\ []) do
    if debug?() do
      logging_path = if Keyword.has_key?(options, :params) do
        path <> "?" <> URI.encode_query(options[:params])
      else
        path
      end

      IO.puts("Request #{method} to #{logging_path}")
    end

    request(method, path, body, headers, options)
  end

  defp pagination_method(response) do
    if response |> Map.has_key?(:_cursor) do
      :cursor
    else
      :pagination
    end
  end

  defp client_id, do: Application.get_env(:ex_twitch, :client_id)

  defp client_headers(%Client{token: token}), do: [{"Authorization", "OAuth #{token}"}]

  defp debug?, do: Application.get_env(:ex_twitch, :debug)
end
