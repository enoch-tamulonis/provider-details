import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  closeUnlessInside(e) {
    if (!this.element.contains(e.target)) {
      this.close()
    }
  }

  close(e) {
    if (e) e.preventDefault()
    this.element.remove()
  }
}
