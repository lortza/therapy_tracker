# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'chartkick', '>= 3.2.0' # chart rendering for ruby data
gem 'coffee-rails', '~> 5.0' # Use CoffeeScript for .coffee assets and views
gem 'devise' # user authentication
gem 'groupdate' # grouping by dates. goes with chartkick
gem 'jbuilder', '~> 2.10' # https://github.com/rails/jbuilder
gem 'pg', '>= 0.18', '< 2.0' # Use postgresql as the database for Active Record
gem 'puma', '~> 4.3' # Use Puma as the app server
gem 'rails', '~> 6.0.3' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sass-rails', '~> 6.0' # Use SCSS for stylesheets
gem 'scss_lint', require: false
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'will_paginate', '~> 3.3.0' # pagination. Styles: http://mislav.github.io/will_paginate/
# gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
# gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'
# gem 'mini_magick', '~> 4.8' # Use ActiveStorage variant
# gem 'mini_racer', platforms: :ruby # https://github.com/rails/execjs#readme
# gem 'momentjs-rails', '>= 2.9.0'
# gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production
# gem 'turbolinks', '~> 5' # https://github.com/turbolinks/turbolinks

group :development do
  # gem 'capistrano-rails' # Use Capistrano for deployment
  gem 'rails-erd', require: false # generates ERD chart for your schema, run `bundle exec erd`
  gem 'rubycritic', require: false # provides feedback on complexity and churns for your codebase
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.4'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'seed_dump' # run with `rake db:seed:dump`
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'awesome_print'
  gem 'better_errors' # creates console in browser for errors
  gem 'binding_of_caller' # goes with better_errors
  gem 'bullet' # detects N+1 queries via config/initializers/bullet.rb
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara' # interacts with the browser
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker' # creates fake data for seeding
  gem 'guard-rspec', require: false # runs rspec automatically
  gem 'launchy' # goes with capybara
  gem 'letter_opener' # lets you send and open test emails via the app
  gem 'lol_dba' # profiles app for performance
  gem 'pry-awesome_print'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 4.0'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.4'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
