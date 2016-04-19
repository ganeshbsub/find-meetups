defmodule FindMeetups.Repo.Migrations.AddMembersToMeetups do
  use Ecto.Migration

  def change do
    alter table(:meetups) do
      add :members, :integer
    end
  end
end
