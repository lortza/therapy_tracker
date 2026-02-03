import { Controller } from "@hotwired/stimulus"

// The ExerciseCounterController manages the exercise rep counter with audio cues.
// It counts through sets and reps with timing and audio feedback.

export default class extends Controller {
  static targets = ["startButton", "stopButton", "setDisplay", "repDisplay", "statusIndicator"]
  static values = {
    sets: Number,
    reps: Number,
    repLength: Number
  }

  connect() {
    // Timer control flags
    this.isRunning = false
    this.shouldStop = false
    this.setsCounter = 1
    this.repsCounter = 1

    // Constants
    this.minRepLength = 2
    this.setRest = 5

    // Calculate actual rep length
    this.actualRepLength = this.repLengthValue === 0 ? this.minRepLength : this.repLengthValue

    // Initialize audio files
    this.soundExerciseBegin = new Audio('/sounds/exercise_begin.wav')
    this.soundExerciseComplete = new Audio('/sounds/exercise_complete.m4a')
    this.soundSetComplete = new Audio('/sounds/set_complete.m4a')
    this.soundRep = new Audio('/sounds/rep.m4a')
  }

  disconnect() {
    // Clean up when controller disconnects
    this.stop()
  }

  start(event) {
    event.preventDefault()

    if (!this.isRunning) {
      this.statusIndicatorTarget.classList.add('hidden')
      this.statusIndicatorTarget.textContent = 'Begin!'
      this.statusIndicatorTarget.classList.remove('hidden')
      this.countSets()
    }
  }

  stop(event) {
    if (event) {
      event.preventDefault()
    }

    this.shouldStop = true
    this.isRunning = false
    this.setsCounter = 1
    this.repsCounter = 1
    console.log('Timer stopped')

    // If there's a stop button with href, navigate after stopping
    if (event && this.stopButtonTarget.href) {
      setTimeout(() => {
        window.location.href = this.stopButtonTarget.href
      }, 100)
    }
  }

  async countSets() {
    this.isRunning = true
    this.shouldStop = false

    this.soundExerciseBegin.play().catch(e => console.log(e))

    while (this.setsCounter <= this.setsValue && !this.shouldStop) {
      console.log("Begin Set " + this.setsCounter)
      this.setDisplayTarget.textContent = this.setsCounter
      this.statusIndicatorTarget.textContent = 'Begin!'

      await this.sleep(2 * 1000)
      if (this.shouldStop) break

      await this.countReps()
      if (this.shouldStop) break

      this.soundSetComplete.play().catch(e => console.log(e))
      await this.sleep(this.setRest * 1000)
      if (this.shouldStop) break

      this.setsCounter++
    }

    this.setsCounter = 1
    this.isRunning = false

    if (!this.shouldStop) {
      this.completeExercise()
    }
  }

  async countReps() {
    while (this.repsCounter <= this.repsValue && !this.shouldStop) {
      console.log(`Set ${this.setsCounter}, rep ${this.repsCounter}`)
      this.repDisplayTarget.textContent = this.repsCounter
      this.soundRep.play().catch(e => console.log(e))

      await this.sleep(this.actualRepLength * 1000)
      if (this.shouldStop) break

      this.repsCounter++
    }

    this.repsCounter = 1

    if (!this.shouldStop) {
      console.log(`Set ${this.setsCounter} complete`)
      this.statusIndicatorTarget.textContent = 'Rest...'
      this.repDisplayTarget.textContent = 0
    }
  }

  completeExercise() {
    console.log('Exercise complete')
    this.statusIndicatorTarget.textContent = 'Finished!'
    this.setDisplayTarget.textContent = 0
    this.repDisplayTarget.textContent = 0
    this.soundExerciseComplete.play().catch(e => console.log(e))
  }

  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
  }
}
