defmodule FindMeetups.MeetupController do
  use FindMeetups.Web, :controller

  alias FindMeetups.Meetup

  plug :scrub_params, "meetup" when action in [:create, :update]

  def index(conn, _params) do

    meetups = Repo.all(Meetup |> Ecto.Query.order_by(desc: :members) |> Ecto.Query.where([c], c.members > 300))
    render(conn, "index.html", meetups: meetups)
  end

  def new(conn, _params) do
    changeset = Meetup.changeset(%Meetup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"meetup" => meetup_params}) do
    changeset = Meetup.changeset(%Meetup{}, meetup_params)

    case Repo.insert(changeset) do
      {:ok, _meetup} ->
        conn
        |> put_flash(:info, "Meetup created successfully.")
        |> redirect(to: meetup_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meetup = Repo.get!(Meetup, id)
    render(conn, "show.html", meetup: meetup)
  end

  def edit(conn, %{"id" => id}) do
    meetup = Repo.get!(Meetup, id)
    changeset = Meetup.changeset(meetup)
    render(conn, "edit.html", meetup: meetup, changeset: changeset)
  end

  def update(conn, %{"id" => id, "meetup" => meetup_params}) do
    meetup = Repo.get!(Meetup, id)
    changeset = Meetup.changeset(meetup, meetup_params)

    case Repo.update(changeset) do
      {:ok, meetup} ->
        conn
        |> put_flash(:info, "Meetup updated successfully.")
        |> redirect(to: meetup_path(conn, :show, meetup))
      {:error, changeset} ->
        render(conn, "edit.html", meetup: meetup, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meetup = Repo.get!(Meetup, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(meetup)

    conn
    |> put_flash(:info, "Meetup deleted successfully.")
    |> redirect(to: meetup_path(conn, :index))
  end
end
