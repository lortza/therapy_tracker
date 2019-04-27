# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# gem 'momentjs-rails', '>= 2.9.0'
# gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise' # user authentication

gem 'chartkick' # chart rendering for ruby data
gem 'groupdate' # grouping by dates. goes with chartkick
gem 'will_paginate', '~> 3.1.0' # pagination. Styles: http://mislav.github.io/will_paginate/

group :development, :test do
  gem 'awesome_print'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'bullet' # detects N+1 queries via config/initializers/bullet.rb
  gem 'faker' # creates fake data for seeding
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-awesome_print'
  gem 'better_errors' # creates console in browser for errors
  gem 'binding_of_caller' #goes with better_errors
  gem 'lol_dba' # profiles app for performance
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara' # interacts with the browser
  gem 'launchy' # goes with capybara
  gem 'factory_bot_rails', '~> 4.0'
  gem 'guard-rspec', require: false # runs rspec automatically
  gem 'letter_opener' # lets you send and open test emails via the app
end

group :development do
  gem 'rails-erd', require: false # generates ERD chart for your schema, run `bundle exec erd`
  gem 'rubycritic', require: false # provides feedback on complexity and churns for your codebase
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "selenium-webdriver"
  gem "chromedriver-helper" # must be loaded after selenium-webdriver
  gem 'seed_dump' # run with `rake db:seed:dump`
  gem 'rubocop', '~> 0.67.2', require: false
  gem 'rubocop-performance'
end

group :test do
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
