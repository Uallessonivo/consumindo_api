defmodule ConsumindoApiWeb.UsersController do
  use ConsumindoApiWeb, :controller

  alias ConsumindoApi.Users.User
  alias ConsumindoApiWeb.Auth.Guardian
  alias ConsumindoApiWeb.FallbackController

  action_fallback(FallbackController)

  def create(conn, params) do
    with {:ok, %User{} = user} <- ConsumindoApi.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- ConsumindoApi.get_user(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
