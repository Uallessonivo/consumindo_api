defmodule ConsumindoApiWeb.RepositoriesController do
  use ConsumindoApiWeb, :controller

  alias ConsumindoApiWeb.FallbackController

  action_fallback FallbackController

  def show(conn, %{"username" => username}) do
    with {:ok, repos} <- ConsumindoApi.get_repos(username) do
      conn
      |> put_status(:ok)
      |> render("show.json", repos: repos)
    end
  end
end
