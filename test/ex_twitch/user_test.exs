defmodule ExTwitch.UserTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import ExTwitch.User

  doctest ExTwitch.User

  @token Application.get_env(:ex_twitch, :token)
  @client ExTwitch.Client.new(@token)

  setup_all do: HTTPoison.start

  test "me/1" do
    use_cassette "user/me_1" do
      {:ok, %ExTwitch.User{} = user} = me(@client)

      assert user._id == "56744667"
      assert user.display_name == "T3hD0gg"
      assert user.name == "t3hd0gg"
      assert user.type == "user"
      assert user.created_at
      assert user.updated_at
    end
  end

  test "user/2 with valid username" do
    use_cassette "user/user_2_username_valid" do
      {:ok, %ExTwitch.User{} = user} = user("vinesauce", @client)

      assert user._id == "25725272"
      assert user.display_name == "Vinesauce"
      assert user.name == "vinesauce"
      assert user.type == "user"
      assert user.bio
      assert user.created_at
      assert user.updated_at
    end
  end

  test "user/2 with invalid username" do
    use_cassette "user/user_2_username_invalid" do
      {:error, %ExTwitch.Error{} = error} = user("this_is_not_going_to_be_valid_hopefully", @client)

      assert error
    end
  end

  test "user/2 with valid user id" do
    use_cassette "user/user_2_user_id_valid" do
      {:ok, %ExTwitch.User{} = user} = user(25725272, @client)

      assert user._id == "25725272"
      assert user.display_name == "Vinesauce"
      assert user.name == "vinesauce"
      assert user.type == "user"
      assert user.bio
      assert user.created_at
      assert user.updated_at
    end
  end

  test "user/2 with invalid user id" do
    use_cassette "user/user_2_user_id_invalid" do
      {:error, %ExTwitch.Error{} = error} = user(999999999, @client)

      assert error
    end
  end

  test "emotes/2 with valid user id" do
    use_cassette "user/emotes_2_user_id_valid" do
      {:ok, emoticon_sets} = emotes(56744667, @client)

      assert Map.has_key?(emoticon_sets, :"0")
      assert Enum.member?(emoticon_sets."0", %{code: "Kappa", id: 25})
    end
  end
end
