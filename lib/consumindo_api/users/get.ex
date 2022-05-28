defmodule ConsumindoApi.Users.Get do
  alias ConsumindoApi.Repo
  alias ConsumindoApi.Users.User
  alias ConsumindoApi.Errors.Error

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end
end
