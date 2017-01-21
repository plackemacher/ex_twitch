defmodule ExTwitch.Badge do
  defstruct ~w(alpha image svg)a

  @type t :: %__MODULE__{
    alpha: binary, image: binary, svg: binary
  }
end