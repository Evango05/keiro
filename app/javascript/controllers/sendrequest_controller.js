import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sendrequest"
export default class extends Controller {



  connect() {
    console.log( "hello je suis connecté");
    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/cycling/${start[0]},${start[1]};${end[0]},${end[1]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`,
      { method: 'GET' }
    );
  }

  createItinerary(){
    fetch(url, )
  }



}
