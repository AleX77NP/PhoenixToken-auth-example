defmodule FoodWeb.MealController do
  use FoodWeb, :controller

  alias Food.Menu
  alias Food.Menu.Meal

  action_fallback FoodWeb.FallbackController

  def index(conn, _params) do
    meals = Menu.list_meals()
    render(conn, "index.json", meals: meals)
  end

  def create(conn, %{"meal" => meal_params}) do
    with {:ok, %Meal{} = meal} <- Menu.create_meal(meal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.meal_path(conn, :show, meal))
      |> render("show.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    meal = Menu.get_meal!(id)
    render(conn, "show.json", meal: meal)
  end

  def update(conn, %{"id" => id, "meal" => meal_params}) do
    meal = Menu.get_meal!(id)

    with {:ok, %Meal{} = meal} <- Menu.update_meal(meal, meal_params) do
      render(conn, "show.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    meal = Menu.get_meal!(id)

    with {:ok, %Meal{}} <- Menu.delete_meal(meal) do
      send_resp(conn, :no_content, "")
    end
  end
end
