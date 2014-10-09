ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'clearance/testing'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending!

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    api_key = '123456789'
    Goodreads.configure(
        api_key: api_key,
        api_secret: 'GOODREADS_API_SECRET'
    )

    stub_request(:get,
      'http://www.goodreads.com/book/isbn' +
      '?format=xml&isbn=9780553801477&key=' +
      api_key).
      to_return(status: 200, body: File.new('./spec/fixtures/goodreads_response.xml'))
  end
end
