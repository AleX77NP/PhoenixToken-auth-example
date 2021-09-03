defmodule Food.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string
      add :price, :integer
      add :description, :string

      timestamps()
    end

  end
end
