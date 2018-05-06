ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'factory_bot'
require 'support/api_v1_helper'
require 'rack/test'
require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include ApiV1Helper
  config.extend ApiClassHelper
  config.include JsonSpec::Helpers

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!


  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    # WebMock.enable!(except: [:typhoeus])

    # stub_request(:get, /maps.googleapis.com/).
    #   with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    #   to_return(status: 200, body: File.read("#{Rails.root}/spec/fixtures/geocoding.json"), headers: {})

    # stub_request(:get, /169.254.169.254/).
    #   with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    #   to_return(status: 200, body: "", headers: {})

    # stub_request(:get, "http://localhost:9200/_aliases").
    #   with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.13.1'}).
    #   to_return(:status => 200, :body => "", :headers => {})
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/system/"])
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
