import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="geolocate"
export default class extends Controller {
static targets = ["longitude", "latitude"]

  connect() {
    console.log( "coucou, salut comment ca va? " )

    const options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0,
    };

    function success(pos) {
      const crd = pos.coords;

      console.log("Your current position is:");
      console.log(`Latitude : ${crd.latitude}`);
      console.log(`Longitude: ${crd.longitude}`);
      console.log(`More or less ${crd.accuracy} meters.`);

      const inputLongitude = document.querySelector(".input-longitude")
      const inputLatitude = document.querySelector(".input-latitude")

      inputLongitude.value = crd.longitude
      inputLatitude.value = crd.latitude
    }

    function error(err) {
      console.warn(`ERROR(${err.code}): ${err.message}`);
    }

    navigator.geolocation.getCurrentPosition(success, error, options);
  }
}
