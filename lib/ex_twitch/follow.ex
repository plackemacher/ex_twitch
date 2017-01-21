defmodule ExTwitch.Follow do
  alias ExTwitch.Channel

  defstruct [:created_at, :notifications, :channel]

  @type t :: %__MODULE__{created_at: binary, notifications: boolean, channel: Channel.t}
end
