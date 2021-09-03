defmodule FoodWeb.AuthController do

  use FoodWeb, :controller
  alias FoodWeb.Auth

  action_fallback FoodWeb.FallbackController


  def get_users() do
    users = [
      %{"id" => 1,"username" => "admin", "password" => "admin", "role" => :admin},
      %{"id" => 2, "username" => "customer", "password" => "12345", "role" => :customer}
    ]
    users
  end

  @spec login(Plug.Conn.t(), map) :: Plug.Conn.t()
  def login(conn, %{"username" => username, "password" => password}) do
    user = Enum.find(get_users(), fn user -> user["username"] == username and user["password"] == password end)
    if user == nil do
      conn
      |> send_resp(404, "wrong credentials")
    else
      token = Auth.generate_token(user["id"])
      conn
      |> send_resp(200, token)
    end
  end

end
