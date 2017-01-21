defmodule ExTwitchTest do
  use ExUnit.Case
  import ExTwitch

  doctest ExTwitch

  test "process_url appends argument to base url" do
    assert process_url("some_path") == "https://api.twitch.tv/kraken/some_path"
  end

  test "process_request_headers appends accept content type" do
    headers = process_request_headers([{"Authorization", "OAuth fake_token"}])

    assert Enum.member?(headers, {"Authorization", "OAuth fake_token"})
    assert Enum.member?(headers, {"Accept", "application/vnd.twitchtv.v5+json"})
  end
end
