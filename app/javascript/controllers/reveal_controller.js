import Reveal from 'stimulus-reveal-controller'

export default class extends Reveal {

  static targets = ["item", "photo"]

  connect() {
    super.connect()
  }

  show(event) {
    const div = this.photoTargets[event.params["index"]]

    this.itemTarget.innerHTML =
    `<span style='font-size:1.3em'> ${div.getAttribute("data-value")}</span>`+
    `<br>`+
    `<span style='font-weight:300'> ${div.getAttribute("data-value-2")}</span>`
    console.log(div.classList.toggle("item-grey"))
  }
}
