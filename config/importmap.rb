# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
# TODO: Upgrade to Bootstrap 5
# pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.5/dist/js/bootstrap.esm.js"
# pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.8/dist/esm/index.js"

pin_all_from "app/javascript/controllers", under: "controllers"

# Chartkick and Chart.js
# pin "chartkick", to: "https://ga.jspm.io/npm:chartkick@5.0.1/dist/chartkick.esm.js"
# pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.4.1/dist/chart.js"
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"

# Custom application JavaScript files
pin_all_from "app/javascript/custom", under: "custom"
