defmodule ExTwitch.Client do
  defstruct [:token, :client_id]

  @type t :: %__MODULE__{token: binary, client_id: binary}

  @spec new :: t
  def new, do: %__MODULE__{}

  @spec append_headers(ExTwitch.Client.t, list) :: list
  def append_headers(client, headers \\ []) do
    headers ++ headers(client)
  end

  def headers(%__MODULE__{token: nil, client_id: client_id}) do
    [{"Client-ID", client_id}]
  end
  def headers(%__MODULE__{token: token, client_id: client_id}) do
    [
      {"Client-ID", client_id},
      {"Authorization", "OAuth #{token}"}
    ]
  end
end
