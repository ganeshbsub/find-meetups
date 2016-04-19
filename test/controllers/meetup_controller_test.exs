defmodule FindMeetups.MeetupControllerTest do
  use FindMeetups.ConnCase

  alias FindMeetups.Meetup
  @valid_attrs %{category: "some content", link: "some content", name: "some content", urlname: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, meetup_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing meetups"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, meetup_path(conn, :new)
    assert html_response(conn, 200) =~ "New meetup"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, meetup_path(conn, :create), meetup: @valid_attrs
    assert redirected_to(conn) == meetup_path(conn, :index)
    assert Repo.get_by(Meetup, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, meetup_path(conn, :create), meetup: @invalid_attrs
    assert html_response(conn, 200) =~ "New meetup"
  end

  test "shows chosen resource", %{conn: conn} do
    meetup = Repo.insert! %Meetup{}
    conn = get conn, meetup_path(conn, :show, meetup)
    assert html_response(conn, 200) =~ "Show meetup"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, meetup_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    meetup = Repo.insert! %Meetup{}
    conn = get conn, meetup_path(conn, :edit, meetup)
    assert html_response(conn, 200) =~ "Edit meetup"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    meetup = Repo.insert! %Meetup{}
    conn = put conn, meetup_path(conn, :update, meetup), meetup: @valid_attrs
    assert redirected_to(conn) == meetup_path(conn, :show, meetup)
    assert Repo.get_by(Meetup, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    meetup = Repo.insert! %Meetup{}
    conn = put conn, meetup_path(conn, :update, meetup), meetup: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit meetup"
  end

  test "deletes chosen resource", %{conn: conn} do
    meetup = Repo.insert! %Meetup{}
    conn = delete conn, meetup_path(conn, :delete, meetup)
    assert redirected_to(conn) == meetup_path(conn, :index)
    refute Repo.get(Meetup, meetup.id)
  end
end
