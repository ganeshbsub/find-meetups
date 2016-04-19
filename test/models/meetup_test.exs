defmodule FindMeetups.MeetupTest do
  use FindMeetups.ModelCase

  alias FindMeetups.Meetup

  @valid_attrs %{category: "some content", link: "some content", name: "some content", urlname: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meetup.changeset(%Meetup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meetup.changeset(%Meetup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
