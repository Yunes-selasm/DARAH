source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 8.0', '>= 8.0.2'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.9'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.6'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

gem 'acts_as_api'

gem 'rack-cors'

gem 'kaminari', '~> 1.2', '>= 1.2.2'

gem 'ransack', '~> 4.3'

gem 'hubspot-api-client', '~> 14.3'

gem 'httplog', '~> 1.7'

gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'rollbar'

gem 'rails_param', '~> 1.3', '>= 1.3.1' # Parameter Validation and Type Coercion for Rails
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'annotate'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'knapsack_pro', '~> 8.4'
  gem 'parallel_tests', '~> 4.3.0'
  gem 'rspec-rails', '~> 6.0'
  gem 'rspec-retry', '~> 0.6.2'

  gem 'pre-commit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', '~> 2.20', '>= 2.20.2'
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'fuubar'
  gem 'shoulda-matchers' # ,'4.0.1'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'timecop'
end

gem "tailwindcss-ruby", "~> 4.1"

gem "tailwindcss-rails", "~> 4.2"
