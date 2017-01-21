defmodule ExTwitch.Badges do
  alias ExTwitch.Badge

  defstruct ~w(admin broadcaster global_mod mod staff subscriber turbo)a

  @type t :: %__MODULE__{
    admin: Badge.t, broadcaster: Badge.t, global_mod: Badge.t, mod: Badge.t, staff: Badge.t,
    subscriber: Badge.t, turbo: Badge.t
  }
end