defmodule FindMeetups.Repo.Migrations.CreateMeetup do
  use Ecto.Migration

  def change do
    create table(:meetups) do
      add :name, :string
      add :urlname, :string
      add :link, :string
      add :category, :string
      add :city_id, references(:cities)
      
      timestamps
    end

  end
end
