defmodule ConsumindoApi do
  alias ConsumindoApi.Repos.Get, as: GetRepositories
  alias ConsumindoApi.Users.Create, as: UserCreate
  alias ConsumindoApi.Users.Update, as: UserUpdate
  alias ConsumindoApi.Users.Get, as: UserGet

  defdelegate get_repos(params), to: GetRepositories, as: :call
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call
  defdelegate get_user(params), to: UserGet, as: :by_id
end
