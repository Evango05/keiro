import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navigation"
export default class extends Controller {
  static targets = ["button", "button2", "button3", "button4"]
  connect() {
    console.log("hello from navigation")
  }

  paused() {
    this.buttonTarget.classList.add("d-none")
    this.button2Target.classList.remove("d-none")
    this.button3Target.classList.remove("d-none")
    this.button4Target.classList.remove("d-none")
  }


}
