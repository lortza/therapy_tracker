import { Controller } from "@hotwired/stimulus"

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
    // Bootstrap 4 requires jQuery
    if (typeof $ !== 'undefined' && $.fn.dropdown) {
      // Dispose of existing dropdown instances to prevent duplicates
      $('[data-toggle="dropdown"]').each(function() {
        const dropdown = $(this).data('bs.dropdown')
        if (dropdown) {
          dropdown.dispose()
        }
      })

      // Initialize all dropdowns
      $('[data-toggle="dropdown"]').dropdown()
    }
  }
}
