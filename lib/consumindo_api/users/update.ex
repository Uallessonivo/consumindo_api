defmodule ConsumindoApi.Users.Update do
  alias ConsumindoApi.Repo
  alias ConsumindoApi.Users.User
  alias ConsumindoApi.Errors.Error

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
