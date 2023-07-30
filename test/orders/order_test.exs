defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.{Item, Order}

  import Exlivery.Factory

  describe "build/2" do
    test "should return an order when all params are valid" do
      user = build(:user)
      items = [
        build(:item),
        build(:item,
          description: "Artesanal hamburger",
          category: :hamburger,
          quantity: 6,
          unit_price: Decimal.new("39.99")
        ),
      ]

      response = Order.build(user, items)
      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "should return error when there isn't items on the list" do
      user = build(:user)
      response = Order.build(user, [])

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
