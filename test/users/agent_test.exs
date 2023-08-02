defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

  describe "save/1" do
    test "should save an user" do
      UserAgent.start_link(%{})

      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "should returns an user if found a user with current cpf" do
      user = build(:user)
      {:ok, user_cpf} = Map.fetch(user, :cpf)

      UserAgent.save(user)

      response = UserAgent.get(user_cpf)

      assert response == {:ok, user}
    end

    test "should returns an error if not found a user with current cpf" do
      :user
      |> build()
      |> UserAgent.save()

      response = UserAgent.get("000000000000")

      assert response == {:error, "user not found"}
    end
  end
end
