defmodule ConsumindoApiWeb.UsersView do
  use ConsumindoApiWeb, :view

  alias ConsumindoApi.Users.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created successfully!",
      token: token,
      user: user
    }
  end

  def render("user.json", %{token: token, user: %User{} = user}) do
    %{
      token: token,
      user: user
    }
  end

  def render("login.json", %{token: token}), do: %{token: token}
end
