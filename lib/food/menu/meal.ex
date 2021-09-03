defmodule Food.Menu.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meals" do
    field :description, :string
    field :name, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:name, :price, :description])
    |> validate_required([:name, :price, :description])
  end
end
