defmodule FindMeetups.PageController do
  use FindMeetups.Web, :controller
  require Logger

  alias FindMeetups.City, as: City
  alias FindMeetups.Meetup, as: Meetup

  def index(conn, _params) do
    render conn, "index.html"
  end

  def get_cities(conn, _params) do
    # !!!! DONE !!!!!
    key="6e3c491fd2471e257c557c1d621e23"
    countries= ["BE", "GR", "LT", "PT", "BG", "ES", "LU", "RO", "CZ", "FR", "HU", "SI", "DK", "HR", "MT", "SK", "DE", "IT", "NL", "FI", "EE", "CY", "AT", "SE", "IE", "LV", "PL", "GB", "NO", "CH", "RS", "TR", "UA"]
    HTTPoison.start
    Enum.each countries, fn(country) ->
      Logger.debug country
      {:ok, response} = HTTPoison.get "https://api.meetup.com/2/cities?country="<>country<>"&key="<>key
      body = Map.get(response, :body)
      
      body = Poison.Parser.parse!(body)
      cities = Map.get(body, "results")
      #cities = Enum.slice(cities, 0, 100)
      Enum.each cities, fn(city) ->
        name = city["city"]
        city_to_be_changed = 
          case Repo.get_by(City, name: name) do
            nil -> %City{}
            result -> result
          end
        city_params = %{name: name, country: country}
        changeset = City.changeset(city_to_be_changed, city_params)
        Repo.insert_or_update(changeset)
      end
    end
    text conn, ""
  end

  def get_meetups(conn, _params) do
    key="6e3c491fd2471e257c557c1d621e23"
    js = "7029"
    ember = "632142"
    locations = Repo.all(City)

    locations = Enum.slice(locations, 3300, 300)
    Enum.each locations, fn(location) ->
      name = String.replace(location.name, " ", "+")
      Logger.debug name
      {:ok, response} = HTTPoison.get "https://api.meetup.com/find/groups?key="<>key<>"&topic_id="<>js<>"&country="<>location.country<>"&location="<>name<>"&order=members&fallback_suggestions=false&radius=1"
      body = Map.get(response, :body)
      meetups = Poison.Parser.parse!(body)

      Logger.debug body
      #(name urlname link category members)

      Enum.each meetups, fn(meetup) ->
        meetup_params = %{name: meetup["name"], urlname: meetup["urlname"], link: meetup["link"], category: "js", members: meetup["members"], city_id: location.id}
        meetup_to_be_changed =
          case Repo.get_by(Meetup, urlname: meetup_params.urlname) do
            nil -> nil
            result -> result
          end

        if meetup_to_be_changed == nil do
          changeset = Meetup.changeset(%Meetup{}, meetup_params)
          {result, model} = Repo.insert_or_update(changeset)
          Logger.debug location.id
        else
          Logger.debug meetup_params.name<>" Already exists"
        end
        
      end

    end

    text conn, ""
  end
end


# javascript id: 7029
# ember-js id: 632142

# https://api.meetup.com/2/cities?country=
# https://api.meetup.com/find/groups?topic_id=&country=&location=

