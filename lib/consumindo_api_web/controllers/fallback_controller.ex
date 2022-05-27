defmodule ConsumindoApiWeb.FallbackController do
  use ConsumindoApiWeb, :controller

  alias ConsumindoApi.Errors.Error
  alias ConsumindoApiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
