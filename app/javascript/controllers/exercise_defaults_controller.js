import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown"]

  change(event) {
    const exerciseId = event.target.value
    if (exerciseId) {
      const url = `/exercises/${exerciseId}`

      fetch(url, {
        headers: {
          Accept: "text/vnd.turbo-stream.html"
        }
      })
        .then(response => response.text())
        .then(html => {
          Turbo.renderStreamMessage(html)
        })
        .catch(error => console.error("Error fetching exercise defaults:", error))
    }
  }
}
