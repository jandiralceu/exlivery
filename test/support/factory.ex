defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User


  def user_factory do
    %User{
      name: "Jandir A. Cutabiala",
      email: "me@jandir.co",
      cpf: "11122233345",
      age: 21,
      address: "Elixir Boulevard 12"
    }
  end

  def item_factory do
    %Item{
      description: "The best pizza in Italy",
      category: :pizza,
      unit_price: Decimal.new("35.50"),
      quantity: 2
    }
  end

  def order_factory do
    %Order{
      user_cpf: "11122233345",
      delivery_address: "Elixir Boulevard 12",
      items: [
        build(:item),
        build(:item,
          description: "Artesanal hamburger",
          category: :hamburger,
          quantity: 6,
          unit_price: Decimal.new("39.99")
        ),
      ],
      total_price: Decimal.new("310.94")
    }
  end
end
