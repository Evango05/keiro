import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="grey-button"
export default class extends Controller {

  static targets = ["button"]

  connect() {
  }

  update() {
  this.buttonTarget.classList.add("big_blue_button");
   }

}
