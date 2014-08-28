ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'turnip/capybara'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir.glob("spec/features/step_definitions/**/*steps.rb") { |f| load f, true }

ActiveRecord::Migration.check_pending!

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    if RSpec.current_example.metadata[:javascript]
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start

    Capybara.current_driver = select_driver

    init_goodreads_api
    stub_isbn_search
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def select_driver
  if RSpec.current_example.metadata[:javascript]
    if RSpec.current_example.metadata[:selenium]
      :selenium
    else
      :webkit
    end
  else
    Capybara.default_driver
  end
end
