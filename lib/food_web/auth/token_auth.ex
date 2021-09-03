defmodule FoodWeb.Auth do

  @moduledoc """
  A module plug that verifies Bearer token, and assigns current_user
  """
  import Plug.Conn
  import Phoenix.Controller


  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> get_token()
    |> verify_token()
    |> case do
      {:ok, user_id} -> assign(conn,:current_user, user_id)
      _unauthorized -> assign(conn, :current_user, nil)
    end
  end

  def authenticate_api_user(conn, _opts) do
    if Map.get(conn.assigns, :current_user) do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(FoodWeb.ErrorView)
      |> render(:"401")
      |> halt()
    end
  end

  def generate_token(user_id) do
    Phoenix.Token.sign(
      FoodWeb.Endpoint,
      "supersecret",
      user_id
    )
  end

  def verify_token(token) do
    one_month = 30 * 24 * 60 * 60

    Phoenix.Token.verify(
      FoodWeb.Endpoint,
      "supersecret",
      token,
      max_age: one_month
    )
  end

  def get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> token
      _ -> nil
    end
  end


end
