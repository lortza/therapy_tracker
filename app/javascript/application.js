// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "controllers"

// Bootstrap 4 (includes Popper.js in bundle)
// Initialized via bootstrap_controller.js
import "bootstrap"

// Chartkick with Chart.js (Chartkick auto-detects Chart.js)
import "chartkick"
import "Chart.bundle"

// Import custom JavaScript files
import "custom/cable"
import "custom/exercise_logs"
import "custom/exercises"
import "custom/logs"
import "custom/pain_log_quick_form_values"
import "custom/pain_logs"
