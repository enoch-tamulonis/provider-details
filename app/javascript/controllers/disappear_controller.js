import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disappear"
export default class extends Controller {
  static values = {
    after: Number,
  }

  connect() {
    setTimeout(this.disappear.bind(this), this.afterValue)
  }

  disappear() {
    this.element.remove()
  }
}
