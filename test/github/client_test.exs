defmodule ConsumindoApi.Github.ClientTest do
  use ExUnit.Case, async: true

  alias ConsumindoApi.Github.Client
  alias ConsumindoApi.Errors.Error

  describe "get_repositories/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid username, return the user repos", %{bypass: bypass} do
      username = "example"

      url = endpoint_url(bypass.port)

      body =
        Jason.encode!([
          %{
            description: "test",
            html_url: "https://github.com/example/test",
            id: 137_494,
            name: "test",
            stargazers_count: 21
          }
        ])

      Bypass.expect(bypass, "GET", "/#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.get_repositories(url, username)

      expected_response =
        {:ok,
         [
           %{
             description: "test",
             html_url: "https://github.com/example/test",
             id: 137_494,
             name: "test",
             stargazers_count: 21
           }
         ]}

      assert response == expected_response
    end

    test "when the username is invalid, return an error", %{bypass: bypass} do
      username = "56qwef4rwer"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "/#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(404, "")
      end)

      response = Client.get_repositories(url, username)

      expected_response =
        {:error,
         %Error{
           result: "Page not found!",
           status: :not_found
         }}

      assert response == expected_response
    end

    test "when the user exists but does not have a repository, return a message", %{
      bypass: bypass
    } do
      username = "uallessonx"

      body = Jason.encode!([])

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "/#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.get_repositories(url, username)

      expected_response =
        {:ok,
         [
           %{
             message: "User doesn't have any public repositories yet."
           }
         ]}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
