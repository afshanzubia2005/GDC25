import requests
import json

API_KEY = "AIzaSyD2jNotloRvwYU-bALHLyv_W0hKpsqWKMA"
# this is my api key 
LOCATION = "40.5169,74.4063"  #new jersey lat/long
RADIUS = 1000000000000  #search radius
QUERY = "nonprofit organization"


nonprofits = []
def fetch_nonprofits():
    url = f"https://maps.googleapis.com/maps/api/place/textsearch/json?query={QUERY}&location={LOCATION}&radius={RADIUS}&key={API_KEY}"
    response = requests.get(url).json()

    print(json.dumps(response, indent=2))


    for result in response.get("results", []):
        nonprofits.append({
            "name": result.get("name"),
            "address": result.get("formatted_address"),
            "place_id": result.get("place_id"),
            "website": result.get("website", "N/A"),
        })

        #    print(result.get("name"))
    return nonprofits

print(fetch_nonprofits())

