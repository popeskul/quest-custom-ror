# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'aasm'
gem 'acts-as-taggable-on', '~> 8.0'
gem 'config'
gem 'devise'
gem 'dry-monads', '~> 1.4'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'mailgun-ruby', '~>1.2.5'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 6.1.4'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'simple_form'
gem 'slim-rails'
gem 'travis'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'launchy'
  gem 'pundit-matchers'
  gem 'rails-controller-testing'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop', require: false
end

group :development do
  gem 'i18n-debug'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
