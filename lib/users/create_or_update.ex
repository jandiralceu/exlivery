defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  @doc "Call the function with params to create and save an user"
  def call(%{cpf: cpf, age: age, name: name, email: email, address: address}) do
    name
    |> User.build(email, cpf, age, address)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "User created or updated successfuly"}
  end

  defp save_user({:error, _reason} = error), do: error
end
