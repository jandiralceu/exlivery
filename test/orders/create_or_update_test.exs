defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      cpf = "11122233311"
      user = build(:user, cpf: cpf)

      Exlivery.start_agents()
      UserAgent.save(user)

      item1 = %{
        description: "Pizza de calabresa",
        category: :pizza,
        unit_price: "45.50",
        quantity: 1
      }

      item2 = %{
        description: "Pizza Cebola",
        category: :pizza,
        unit_price: "30.50",
        quantity: 2
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "should return an order when all params are valid", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "should return an error when user cpf is invalid", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: "00000000011", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert response == {:error, "user not found"}
    end

    test "should return an error if has invalid items", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      assert response == {:error, "Invalid struct"}
    end

    test "should return an error if the items list is empty", %{user_cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)

      assert response == {:error, "Invalid parameters"}
    end
  end
end
