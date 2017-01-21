defmodule ExTwitch.Client do
  defstruct [:token]

  @type t :: %__MODULE__{token: binary}

  @spec new :: t
  def new, do: %__MODULE__{}

  @spec new(binary) :: t
  def new(token), do: %__MODULE__{token: token}
end
