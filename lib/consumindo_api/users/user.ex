defmodule ConsumindoApi.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:password, :email, :name]
  @derive {Jason.Encoder, only: [:id, :email, :name]}

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> hash_password()
  end

  defp hash_password(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp hash_password(changeset), do: changeset
end
