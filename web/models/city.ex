defmodule FindMeetups.City do
  use FindMeetups.Web, :model

  schema "cities" do
    field :name, :string
    field :country, :string
    has_many :meetups, FindMeetups.Meetup
    timestamps
  end

  @required_fields ~w(name country)
  @optional_fields ~w()

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
