# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.0.0/flowbite.turbo.min.js"
pin "mapkick/bundle", to: "mapkick.bundle.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/custom", under: "custom"

#pin "algoliasearch", to: "https://cdn.jsdelivr.net/npm/algoliasearch@4.22.1/dist/algoliasearch-lite.umd.js"
#pin "instantsearch", to: "https://cdn.jsdelivr.net/npm/instantsearch.js@4.64.2/dist/instantsearch.production.min.js"