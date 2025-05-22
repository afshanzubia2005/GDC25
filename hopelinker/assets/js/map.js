//const newDiv = document.createElement('div');
// create new div to hold the map element
//newDiv.id = 'map';


// hardcoded coordinate points of NJIT as map center: [40.7424, -74.1784] with zoom value of 5 -->

const addressString = '182 Warren St, Newark, NJ 07103';

function buildQuery(address) {
    const uriAddress = encodeURIComponent(address);
    return `https://nominatim.openstreetmap.org/search?q=${uriAddress}&format=jsonv2`;
}

async function getCoordinates(address){
    //makes API call to turn the address into lat/lon coordinates
    const query = buildQuery(address);

    const response = await fetch(query, {
        headers: {
            'User-Agent': 'HopeLinker (aa3526@njit.edu)',  // May be ignored by browsers
            'Accept': 'application/json'
        }

    });

    if (!response.ok){
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();

    if(!data.length){
        throw new Error(`No results found for the address`)
    }

    const coordinates = [parseFloat(data[0].lat), parseFloat(data[0].lon)];
    return coordinates;
}
getCoordinates(addressString).then(
    coordinates => {
    console.log(coordinates);     
    var coordinates1 = coordinates;
    var map = L.map('map').setView(40.7424, -74.1784); // previous setView coordinates: coordinates1, 17
    
    L.maplibreGL({
      style: 'https://tiles.openfreemap.org/styles/bright'
    }).addTo(map);
    
  });
