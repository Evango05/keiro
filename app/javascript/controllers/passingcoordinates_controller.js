import { Controller } from "@hotwired/stimulus"



// Connects to data-controller="passingcoordinates"
export default class extends Controller {

  static values = {
    apiKey: String,
    itineraryRoute: Object
  }

  connect() {
    console.log(this.itineraryRouteValue.routes[0].geometry);


    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v12',
    })
    this.map.on('load', () => {
      this.map.addSource('route', {
        'type': 'geojson',
        'data': {
          'type': 'Feature',
          'properties': {},
          'geometry': this.itineraryRouteValue.routes[0].geometry
        }
      });

      this.map.addLayer({
        'id': 'route',
        'type': 'line',
        'source': 'route',
        'layout': {
          'line-join': 'round',
          'line-cap': 'round'
        },
        'paint': {
          'line-color': '#FF0000',
          'line-width': 8
        }
      });
    });

    this.#fitMapToMarkers(this.itineraryRouteValue.routes[0].geometry.coordinates)
  }


  #showItineraryOnMap() {

  }

  #fitMapToMarkers(points) {
    const bounds = new mapboxgl.LngLatBounds()
    points.forEach(marker => bounds.extend(marker))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0})
  }





}
