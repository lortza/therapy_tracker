# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip

gem "rails", "8.0.4"
gem "puma", "~> 7.2" # Use Puma as the app server
gem "pg", ">= 0.18", "< 2.0" # Use postgresql as the database for Active Record
gem "dartsass-rails" # Use Dart Sass for stylesheets

gem "hotwire-rails"
gem "sdoc", "~> 2.6.1", group: :doc

gem "propshaft" # The modern asset pipeline for Rails [https://github.com/rails/propshaft]

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

gem "bootsnap", require: false
gem "chartkick" # chart rendering for ruby data https://chartkick.com/
gem "devise" # user authentication
gem "groupdate" # grouping by dates. goes with chartkick
gem "will_paginate", "~> 4.0.1" # pagination. Styles: http://mislav.github.io/will_paginate/
gem "scss_lint", require: false

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
# gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# gem 'turbolinks', '~> 5' # https://github.com/turbolinks/turbolinks
gem "net-imap", require: false
gem "net-pop", require: false
gem "net-smtp", require: false # Send internet mail via SMTP
gem "sentry-rails"                      # Rails support for Sentry
gem "sentry-ruby"  # Error reporting to Sentry.io
gem "draper" # decorator facilitation
gem "bootstrap", "~> 4.1.3"

group :development do
  gem "rack-mini-profiler"
  # gem 'capistrano-rails' # Use Capistrano for deployment
  gem "rails-erd", require: false # generates ERD chart for your schema, run `bundle exec erd`
  gem "rubycritic", require: false # provides feedback on complexity and churns for your codebase
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.11"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "standard"
  gem "seed_dump" # run with `rake db:seed:dump`
  gem "spring"
  gem "spring-watcher-listen", "~> 2.1.0"
end

group :development, :test do
  gem "awesome_print"
  gem "better_errors" # creates console in browser for errors
  gem "binding_of_caller" # goes with better_errors
  gem "bullet" # detects N+1 queries via config/initializers/bullet.rb
  gem "byebug", platforms: %i[mri windows]
  gem "capybara" # interacts with the browser
  gem "factory_bot_rails", "~> 6.5"
  gem "faker" # creates fake data for seeding
  gem "guard-rspec", require: false # runs rspec automatically
  gem "launchy" # goes with capybara
  gem "letter_opener" # lets you send and open test emails via the app
  gem "lol_dba" # profiles app for performance
  gem "pry-awesome_print"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 8.0"
  gem "selenium-webdriver"
end

group :test do
  gem "database_cleaner"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]
