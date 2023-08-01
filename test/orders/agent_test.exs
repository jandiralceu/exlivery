defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrdersAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "save/1" do
    test "should save an order" do
      OrdersAgent.start_link(%{})

      order = build(:order)

      assert {:ok, _uuid} = OrdersAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrdersAgent.start_link(%{})
      :ok
    end

    test "should returns an order if current uuid exists" do
      order = build(:order)
      {:ok, uuid} = OrdersAgent.save(order)

      response = OrdersAgent.get(uuid)

      expected_response = {
        :ok,
        %Order{
          user_cpf: "11122233345",
          delivery_address: "Elixir Boulevard 12",
          items: [
            %Item{
              description: "The best pizza in Italy",
              category: :pizza,
              unit_price: Decimal.new("35.50"),
              quantity: 2
            },
            %Item{
              description: "Artesanal hamburger",
              category: :hamburger,
              unit_price: Decimal.new("39.99"),
              quantity: 6
            }
          ],
          total_price: Decimal.new("310.94")
        }
      }

      assert response == expected_response
    end

    test "should returns an error if not find a order with current uuid" do
      response = OrdersAgent.get("2sdf-34234-ertetgd-23424")

      assert response == {:error, "Order not found"}
    end
  end
end
