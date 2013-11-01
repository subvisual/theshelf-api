require 'cucumber/rails'
require 'pry'
require 'factory_girl'
require 'capybara-webkit'

include FactoryGirl::Syntax::Methods

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation
