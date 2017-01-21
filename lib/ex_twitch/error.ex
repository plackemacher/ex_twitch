defmodule ExTwitch.Error do
  defstruct ~w(message status error)a

  @type t :: %__MODULE__{
    message: binary, status: integer, error: binary
  }
end
