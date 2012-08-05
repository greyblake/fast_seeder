require 'rubygems'

# Configure Rails Envinronment
ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/autorun'
require 'rspec/rails'
require 'pry'

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
end

