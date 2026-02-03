import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["painDropdown", "painLevel", "painDescription", "painTrigger"]

  handleChange() {
    const selectedPainItem = this.painDropdownTarget.options[this.painDropdownTarget.selectedIndex].text.toLowerCase()

    if (selectedPainItem === 'none') {
      this.populateNoPainData()
    }
  }

  populateNoPainData() {
    this.painLevelTarget.value = 0
    this.painDescriptionTarget.value = 'none'
    this.painTriggerTarget.focus()
    this.painTriggerTarget.select()
  }
}
