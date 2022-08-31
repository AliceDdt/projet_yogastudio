# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.1.3/app/javascript/turbo/index.js", preload: true
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@7.1.0/dist/turbo.es2017-esm.js", preload: true
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.0.3/src/index.js", preload: true
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.3-1/lib/assets/compiled/rails-ujs.js"
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
# pin 'stimulus-use', to: 'https://cdn.jsdelivr.net/npm/stimulus-use@0.50.0-2/dist/index.min.js'
# pin 'hotkeys-js', to: 'https://cdn.jsdelivr.net/npm/hotkeys-js@3.7.3/index.min.js', preload: true
pin_all_from "app/javascript/controllers", under: "controllers"