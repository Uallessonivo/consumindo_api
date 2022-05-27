defmodule ConsumindoApi.Repos.Get do
  alias ConsumindoApi.Errors.Error

  def call(username) do
    with {:ok, repos} <- client().get_repositories(username) do
      {:ok, repos}
    else
      {:error, %Error{}} = error -> error
    end
  end

  defp client do
    :consumindo_api
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:get_repositories_adapter)
  end
end
