defmodule FindMeetups.Meetup do
  use FindMeetups.Web, :model

  schema "meetups" do
    field :name, :string
    field :urlname, :string
    field :link, :string
    field :category, :string
    field :members, :integer

    belongs_to :city, FindMeetups.City

    timestamps
  end

  @required_fields ~w(name urlname link category members)
  @optional_fields ~w(city_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
