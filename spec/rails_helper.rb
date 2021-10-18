# frozen_string_literal: true

require 'spec_helper'
require 'simplecov'
require 'pundit/rspec'
require 'aasm/rspec'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/**/support/**/*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec/**/concerns/**/*.rb')].sort.each { |f| require f }
Dir[Rails.root.join('spec/**/services/**/*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
  config.include FeatureHelpers, type: :feature
  config.include MailerHelpers, type: :mailer

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  Capybara.javascript_driver = :selenium_chrome_headless

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.after(:all) do
    FileUtils.rm_rf("#{Rails.root}/tmp/storage")
  end

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    DatabaseCleaner.strategy = :truncation unless driver_shares_db_connection_with_specs
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
