ENV['RAILS_ENV'] ||= 'test'
require 'coveralls'
Coveralls.wear! 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  def login user
    session[:user_id] = user.id
  end
end
