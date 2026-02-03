import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bootstrap"
export default class extends Controller {
  connect() {
    this.initializeDropdowns()

    // Listen for Turbo events to reinitialize
    document.addEventListener("turbo:load", this.initializeDropdowns.bind(this))
    document.addEventListener("turbo:render", this.initializeDropdowns.bind(this))
    document.addEventListener("turbo:frame-load", this.initializeDropdowns.bind(this))
  }

  disconnect() {
    // Clean up event listeners
    document.removeEventListener("turbo:load", this.initializeDropdowns.bind(this))
    document.removeEventListener("turbo:render", this.initializeDropdowns.bind(this))
    document.removeEventListener("turbo:frame-load", this.initializeDropdowns.bind(this))
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
