defmodule ConsumindoApi do
  alias ConsumindoApi.Repos.Get, as: GetRepositories

  defdelegate get_repos(params), to: GetRepositories, as: :call
end
