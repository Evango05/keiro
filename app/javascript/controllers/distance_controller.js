import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="distance"
export default class extends Controller {
  static targets = ["distanceinput", "distanceinject"]

  connect() {
    console.log("coucou cest le controller distance");
  }

  update() {
    console.log("update");
    this.distanceinjectTarget.innerHTML = `${this.distanceinputTarget.value} km`;
  }
}
