import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recap"
export default class extends Controller {
  static targets = ["button_fav", "button_share", "star"]


  connect() {
  }

  favorite(){
    this.button_favTarget.classList.toggle("d-none")
    this.starTarget.classList.toggle("yellow_star")

  }

  share(){
    this.button_shareTarget.classList.toggle("d-none");
  }
}
