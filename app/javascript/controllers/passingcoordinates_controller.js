import { Controller } from "@hotwired/stimulus"



// Connects to data-controller="passingcoordinates"
export default class extends Controller {

  static values = {
    apiKey: String,
    itineraryRoute: Object
  }

  connect() {
    // console.log(this.itineraryRouteValue.routes[0].geometry);


    // je définis une distance isochrone = à la moitié de ma distance
    const contours_meters = this.itineraryRouteValue.routes[0].length / 2

    // j'essaie de vérifier si mes points sont dans l'isochrone
    this.itineraryRouteValue.routes[0].geometry.coordinates

    https://api.mapbox.com/isochrone/v1/{profile}/{coordinates}?{contours_minutes|contours_meters}

    // ca va jusqu'ici

    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/adrienlupo/clf79uzmp009701pgdvrmpuvv',
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

          'line-color': '#1A15FF',
          'line-width': 6

        }
      });
    });

    this.#fitMapToMarkers(this.itineraryRouteValue.routes[0].geometry.coordinates)
  }


  #fitMapToMarkers(points) {
    const bounds = new mapboxgl.LngLatBounds()
    points.forEach(marker => bounds.extend(marker))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0})
  }

}
