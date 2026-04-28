import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  clear() {
    // this.element.remove();
    this.element.innerHTML = '';
  }
}
