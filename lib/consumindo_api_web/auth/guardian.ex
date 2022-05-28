defmodule ConsumindoApiWeb.Auth.Guardian do
  use Guardian, otp_app: :consumindo_api

  alias ConsumindoApi.Users.User
  alias ConsumindoApi.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end
end
