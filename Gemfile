source "https://rubygems.org"

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# ViewComponent [https://viewcomponent.org/]
gem "view_component"

# Draper for decorators patterns [https://github.com/drapergem/draper]
gem "draper"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Devise for authentification [https://github.com/heartcombo/devise]
gem "devise"

# Paginate models [https://github.com/ddnexus/pagy]
gem "pagy"

# Geocoding and maps [https://github.com/mapbox/mapbox-sdk-rb]
gem 'mapbox-sdk'

# Create maps over a Ruby line code [https://github.com/ankane/mapkick/tree/master]
gem 'mapkick-rb'

# Manage application variable environment [https://github.com/laserlemon/figaro]
gem 'figaro'

# Complete geocoding solution for Ruby [https://github.com/alexreisner/geocoder]
gem 'geocoder'

# Solution for managing countries, timezone and currencies [https://github.com/countries/countries]
gem 'countries'
gem 'timezone'
gem 'money'

# Friendly ID for slugs [https://github.com/norman/friendly_id]
gem 'friendly_id'

# sitemap_generator [https://github.com/kjvarga/sitemap_generator]
gem 'sitemap_generator'

# generate variants images [https://github.com/janko/image_processing]
gem "image_processing", "~> 1.0"

# Search using AI [https://algolia.com]
gem "algoliasearch-rails"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'pry', '~> 0.14.2'
  gem 'bullet'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
