import Reveal from 'stimulus-reveal-controller'

export default class extends Reveal {

  static targets = ["item", "photo"]

  connect() {
    super.connect()
  }

  show(event) {
    const div = this.photoTargets[event.params["index"]]
    this.itemTarget.innerHTML = `${div.getAttribute("data-value")} <br> <br> ${div.getAttribute("data-value-2")}`
    console.log(div.classList.toggle("item-grey"))
  }
}
