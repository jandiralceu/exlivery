defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "should save or update the user if all params are corrects" do
      params = %{
        cpf: "11122233344",
        age: 32,
        name: "Alceu Kutabyala",
        email: "me@alceu.co",
        address: "Elixir Boulevard 1234"
      }

      response = CreateOrUpdate.call(params)

      assert response == {:ok, "User created or updated successfuly"}
    end

    test "should returns an error if paramas are invalid" do
      params = %{
        cpf: "11122233344",
        age: 10,
        name: "Will Smith",
        email: "me@willsmith.co",
        address: "Elixir Boulevard 1234"
      }

      response = CreateOrUpdate.call(params)

      assert response == {:error, "Invalid parameters"}
    end
  end
end
