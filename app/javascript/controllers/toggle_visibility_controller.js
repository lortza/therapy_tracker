import { Controller } from "@hotwired/stimulus"

// Toggles visibility of target elements based on checkbox state
export default class extends Controller {
  static targets = ["content"]

  connect() {
    // Store reference and parent info on first connect
    this.storedContent = this.contentTarget // The element itself
    this.contentParent = this.contentTarget.parentNode // Where it belongs in the DOM
    this.insertionPoint = this.contentTarget.nextSibling // Where exactly to put it back if removed
    this.toggle()
  }

  toggle() {
    const checkbox = this.element.querySelector('input[type="checkbox"]')

    if (checkbox.checked) {
      // Re-insert content if it was removed
      if (!this.storedContent.parentNode) {
        if (this.insertionPoint && this.insertionPoint.parentNode) {
          this.contentParent.insertBefore(this.storedContent, this.insertionPoint)
        } else {
          this.contentParent.appendChild(this.storedContent)
        }
      }
      this.storedContent.style.display = 'block'
    } else {
      // Remove from DOM
      this.storedContent.remove()
    }
  }
}
