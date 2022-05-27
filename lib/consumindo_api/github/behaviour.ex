defmodule ConsumindoApi.Github.Behaviour do
  alias ConsumindoApi.Errors.Error

  @callback get_repositories(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
