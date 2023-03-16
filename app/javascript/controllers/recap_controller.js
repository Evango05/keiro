import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recap"
export default class extends Controller {
  static targets = ["button_fav", "button_share"]


  connect() {

    console.log("hello from recap")
  }

  favorite(){
    this.button_favTarget.classList.remove("d-none")

  }

  share(){
    this.button_shareTarget.classList.remove("d-none")
  }
}
