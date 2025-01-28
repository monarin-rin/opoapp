pin "application", preload: true

# Turbo & Stimulus
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# Controllers
pin_all_from "app/javascript/controllers", under: "controllers"
