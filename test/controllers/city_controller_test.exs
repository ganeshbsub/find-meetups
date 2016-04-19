defmodule FindMeetups.CityControllerTest do
  use FindMeetups.ConnCase

  alias FindMeetups.City
  @valid_attrs %{country: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, city_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing cities"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, city_path(conn, :new)
    assert html_response(conn, 200) =~ "New city"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, city_path(conn, :create), city: @valid_attrs
    assert redirected_to(conn) == city_path(conn, :index)
    assert Repo.get_by(City, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, city_path(conn, :create), city: @invalid_attrs
    assert html_response(conn, 200) =~ "New city"
  end

  test "shows chosen resource", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = get conn, city_path(conn, :show, city)
    assert html_response(conn, 200) =~ "Show city"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, city_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = get conn, city_path(conn, :edit, city)
    assert html_response(conn, 200) =~ "Edit city"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = put conn, city_path(conn, :update, city), city: @valid_attrs
    assert redirected_to(conn) == city_path(conn, :show, city)
    assert Repo.get_by(City, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = put conn, city_path(conn, :update, city), city: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit city"
  end

  test "deletes chosen resource", %{conn: conn} do
    city = Repo.insert! %City{}
    conn = delete conn, city_path(conn, :delete, city)
    assert redirected_to(conn) == city_path(conn, :index)
    refute Repo.get(City, city.id)
  end
end
