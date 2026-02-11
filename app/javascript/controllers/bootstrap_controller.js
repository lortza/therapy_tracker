import { Controller } from "@hotwired/stimulus"
import { Dropdown } from "bootstrap"

// Connects to data-controller="bootstrap"
export default class extends Controller {
  connect() {
    // Store bound function references so we can remove them later
    this.boundInitializeDropdowns = this.initializeDropdowns.bind(this)

    // Initialize dropdowns on connect
    this.initializeDropdowns()

    // Listen for Turbo events to reinitialize
    document.addEventListener("turbo:load", this.boundInitializeDropdowns)
    document.addEventListener("turbo:render", this.boundInitializeDropdowns)
    document.addEventListener("turbo:frame-load", this.boundInitializeDropdowns)
  }

  disconnect() {
    // Clean up event listeners using the stored bound references
    document.removeEventListener("turbo:load", this.boundInitializeDropdowns)
    document.removeEventListener("turbo:render", this.boundInitializeDropdowns)
    document.removeEventListener("turbo:frame-load", this.boundInitializeDropdowns)
  }

  initializeDropdowns() {
    // Bootstrap 5 doesn't require jQuery - use native JavaScript
    const dropdownToggles = document.querySelectorAll('[data-bs-toggle="dropdown"]')

    dropdownToggles.forEach(toggleElement => {
      // Get existing dropdown instance if any
      const existingDropdown = Dropdown.getInstance(toggleElement)

      // Dispose of existing instance to prevent duplicates
      if (existingDropdown) {
        existingDropdown.dispose()
      }

      // Initialize new dropdown instance
      new Dropdown(toggleElement)
    })
  }
}
