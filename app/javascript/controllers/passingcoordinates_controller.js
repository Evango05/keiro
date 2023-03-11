import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="passingcoordinates"
export default class extends Controller {
  connect() {
    console.log("hello hello")
  }
}
