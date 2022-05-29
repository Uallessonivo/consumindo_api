defmodule ConsumindoApiWeb.Auth.RefreshToken do
  alias ConsumindoApiWeb.Auth.Guardian

  def refresh_token(conn) do
    with old_token <- Guardian.Plug.current_token(conn),
         {:ok, _old, {new_token, _claims}} <- Guardian.refresh(old_token, ttl: {1, :minute}) do
      new_token
    end
  end
end
