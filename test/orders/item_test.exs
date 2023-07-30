defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "should return an item when all params are valid" do
      response = Item.build(
        "The best pizza in Italy",
        :pizza,
        "35.50",
        2
      )
      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "should return error if category is invalid" do
      response = Item.build(
        "The best pizza in Italy",
        :no_exist,
        "35.50",
        2
      )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "should return error if price is invalid" do
      response = Item.build(
        "The best pizza in Italy",
        :pizza,
        "invalid_number",
        2
      )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "should return error if quantity is less or equals to 0" do
      response = Item.build(
        "The best pizza in Italy",
        :pizza,
        "50.60",
        0
      )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

  end
end
