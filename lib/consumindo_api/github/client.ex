defmodule ConsumindoApi.Github.Client do
  use Tesla

  alias ConsumindoApi.Errors.Error
  alias ConsumindoApi.Github.Behaviour

  @behaviour Behaviour

  @base_url "https://api.github.com/users"
  @request_headers [{"user-agent", "Tesla"}]

  plug Tesla.Middleware.Headers, @request_headers
  plug Tesla.Middleware.JSON

  def get_repositories(url \\ @base_url, username) do
    "#{url}/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: []}}) do
    {:ok, [%{message: "User doesn't have any public repositories yet."}]}
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok,
     Enum.map(body, fn repo ->
       %{
         id: repo["id"],
         name: repo["name"],
         description: repo["description"],
         html_url: repo["html_url"],
         stargazers_count: repo["stargazers_count"]
       }
     end)}
  end

  defp handle_get({:ok, %Tesla.Env{status: 403}}) do
    {:error, Error.build(:forbidden, "Request forbidden by administrative rules!")}
  end

  defp handle_get({:ok, %Tesla.Env{status: 404}}) do
    {:error, Error.build(:not_found, "Page not found!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
