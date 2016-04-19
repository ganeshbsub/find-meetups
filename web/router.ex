defmodule FindMeetups.Router do
  use FindMeetups.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FindMeetups do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/meetups", MeetupController
    resources "/cities", CityController
  end

  # Other scopes may use custom stacks.
  scope "/api", FindMeetups do
    pipe_through :api

    get "/meetups", PageController, :get_meetups
    get "/cities", PageController, :get_cities
  end
end
