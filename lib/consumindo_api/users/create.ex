defmodule ConsumindoApi.Users.Create do
  alias ConsumindoApi.Repo
  alias ConsumindoApi.Users.User
  alias ConsumindoApi.Errors.Error

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = user) do
    user
  end

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
