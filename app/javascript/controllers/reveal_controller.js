import Reveal from 'stimulus-reveal-controller'

export default class extends Reveal {

  static targets = ["item", "photo"]

  connect() {
    super.connect()
  }

  show(event) {
    // console.log(event.params["index"])
    // console.log(this.photoTargets)
    const div = this.photoTargets[event.params["index"]]
    this.itemTarget.innerHTML = `${div.getAttribute("data-value")} <br> <br> ${div.getAttribute("data-value-2")}`
  }
}
