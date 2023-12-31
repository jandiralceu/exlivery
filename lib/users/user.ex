defmodule Exlivery.Users.User do
  @keys [:name, :email, :cpf, :age, :address]
  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf, age, address) when age >= 18 do
    {
      :ok,
      %__MODULE__{
        cpf: cpf,
        age: age,
        name: name,
        email: email,
        address: address
      }
    }
  end

  def build(_name, _email, _cpf, _age, _address) do
    {:error, "Invalid parameters"}
  end
end
