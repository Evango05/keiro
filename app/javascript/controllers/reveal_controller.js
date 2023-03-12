import Reveal from 'stimulus-reveal-controller'

export default class extends Reveal {

  static targets = ["item", "photo"]

  connect() {
    super.connect()
    console.log(this.photoTarget)
  }
}
