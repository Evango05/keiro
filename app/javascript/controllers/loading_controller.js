import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["content", "gif"]

  connect() {
  }

  remove(e) {
    e.preventDefault();
    this.contentTarget.classList.add("d-none");
    this.gifTarget.classList.remove("d-none");
    setTimeout(() => {
      e.target.submit();
    }, 2000);
}
}
