import { Controller } from "@hotwired/stimulus"

// The SlitTimerController manages the countdown timer for SLIT (sublingual immunotherapy) doses.
// It counts down from 2:01 to 0:00, plays a sound when complete, and handles dismiss/cancel actions.

export default class extends Controller {
  static targets = ["clock", "dismissButton", "cancelButton"]
  static values = {
    duration: { type: Number } // Default set in SlitLog model
  }

  connect() {
    this.timerTimeout = null
    this.isTimerStopped = false
    this.audioEnabled = !this.element.dataset.disableAudio

    // Auto-start the timer when connected
    this.start()
  }

  disconnect() {
    this.stop()
  }

  // Start the timer countdown
  start() {
    // Initialize state
    this.isTimerStopped = false
    this.remainingSeconds = this.durationValue

    // Start counting
    this.updateDisplay()
    this.tick()
  }

  // Main timer tick function
  tick() {
    if (this.isTimerStopped) {
      console.log('Timer is stopped, not continuing')
      return
    }

    // Countdown
    this.remainingSeconds--

    // Check if timer is complete
    if (this.remainingSeconds < 0) {
      this.complete()
      return
    }

    // Update display and schedule next tick
    this.updateDisplay()
    this.timerTimeout = setTimeout(() => this.tick(), 1000)
  }

  // Update the clock display
  updateDisplay() {
    const minutes = Math.floor(this.remainingSeconds / 60)
    const seconds = this.remainingSeconds % 60
    const formattedSeconds = seconds < 10 ? `0${seconds}` : seconds
    this.clockTarget.textContent = `${minutes}:${formattedSeconds}`
  }

  // Complete the timer
  complete() {
    console.log('Timer ended')

    // Play completion sound
    if (this.audioEnabled) {
      const soundExerciseComplete = new Audio('/sounds/exercise_complete.m4a')
      soundExerciseComplete.play().catch(e => console.log(e))
    }

    // Show dismiss button, hide cancel button
    this.cancelButtonTarget.classList.add('hidden')
    this.dismissButtonTarget.classList.remove('hidden')
  }

  // Cancel the timer (called when cancel button is clicked)
  cancel(event) {
    event.preventDefault()
    this.stop()
    this.remove()
  }

  // Dismiss the timer (called when dismiss button is clicked after completion)
  dismiss(event) {
    event.preventDefault()
    this.stop()
    this.remove()
  }

  // Remove the timer element from the DOM
  remove() {
    this.element.remove()
  }

  // Stop the timer
  stop() {
    this.isTimerStopped = true
    if (this.timerTimeout) {
      clearTimeout(this.timerTimeout)
      this.timerTimeout = null
    }
    console.log('Timer stopped')
  }
}
