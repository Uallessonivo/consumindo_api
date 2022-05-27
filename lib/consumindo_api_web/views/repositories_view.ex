defmodule ConsumindoApiWeb.RepositoriesView do
  use ConsumindoApiWeb, :view

  def render("show.json", %{repos: repos}) do
    %{
      repos: repos
    }
  end
end
