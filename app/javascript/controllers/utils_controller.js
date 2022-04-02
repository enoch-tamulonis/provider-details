import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="utils"
export default class extends Controller {
  static targets = ["element"]
  static values = {
    string: String,
  }

  removeClass() {
    this.elementTarget.classList.remove(this.stringValue)
  }
}
