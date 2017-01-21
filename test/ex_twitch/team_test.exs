defmodule ExTwitch.TeamTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import ExTwitch.Team

  doctest ExTwitch.Team

  @token Application.get_env(:ex_twitch, :token)
  @client ExTwitch.Client.new(@token)

  setup_all do: HTTPoison.start

  test "team/2 with valid team" do
    use_cassette "team/team_2_valid_team" do
      {:ok, %ExTwitch.Team{} = team} = team("vinesauce", @client)

      assert team._id == 1372
      assert team.name == "vinesauce"
      assert team.display_name == "Vinesauce"
      assert is_list(team.users)
    end
  end

  test "team/2 with invalid team" do
    use_cassette "team/team_2_invalid_team" do
      {:error, %ExTwitch.Error{} = error} = team("this_is_a_team_name_no_one_should_make", @client)

      assert error.status == 404
    end
  end
end
