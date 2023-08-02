defmodule Exlivery.Orders.Agent do
  @moduledoc "Implements the Orders Agent"
  alias Exlivery.Orders.Order

  use Agent

  @doc "Start the Agent"
  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc "Save the Order"
  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, order, uuid))

    {:ok, uuid}
  end

  @doc "Get the Order based on uuid"
  def get(uuid), do: Agent.get(__MODULE__, &get_order!(&1, uuid))

  defp get_order!(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end

  defp update_state(state, %Order{} = order, uuid) do
    Map.put(state, uuid, order)
  end
end
