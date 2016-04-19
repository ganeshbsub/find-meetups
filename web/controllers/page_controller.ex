defmodule FindMeetups.PageController do
  use FindMeetups.Web, :controller
  require Logger

  alias FindMeetups.City, as: City
  alias FindMeetups.Meetup, as: Meetup

  def index(conn, _params) do
    render conn, "index.html"
  end

  def get_meetups(conn, params) do
    key="6e3c491fd2471e257c557c1d621e23"
    countries= ["BE", "GR", "LT", "PT", "BG", "ES", "LU", "RO", "CZ", "FR", "HU", "SI", "DK", "HR", "MT", "SK", "DE", "IT", "NL", "FI", "EE", "CY", "AT", "SE", "IE", "LV", "PL", "GB", "NO", "CH", "RS", "TR", "UA"]
    HTTPoison.start

    Enum.each countries, fn(country) ->
      Logger.debug country
      {:ok, response} = HTTPoison.get "https://api.meetup.com/2/cities?country="<>country<>"&key="<>key
      body = Map.get(response, :body)
      
      body = Poison.Parser.parse!(body)
      cities = Map.get(body, "results")
      Logger.debug List.first(results)["city"]

      Enum.each cities, fn(city) ->
        
      end

    end

    conn(200, "")
  end
end


# javascript id: 7029
# ember-js id: 632142

# https://api.meetup.com/2/cities?country=
# https://api.meetup.com/find/groups?topic_id=&country=&location=