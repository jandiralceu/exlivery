defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "should return a user when all params are valid" do
      response = User.build(
        "Jandir A. Cutabiala",
        "me@jandir.co",
        "11122233345",
        21,
        "Elixir Boulevard 12"
      )
      expected_response = {:ok, build(:user) }

      assert response == expected_response
    end

    test "should returns an error when params are invalid" do
      response = User.build(
        "Lionel Messi",
        "me@messi.ar",
        "11122233345",
        12,
        "Avenida de Mayo 920"
      )

      assert response == {:error, "Invalid parameters"}
    end
  end
end
