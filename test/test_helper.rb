ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require_relative "../app/presenters/user_profile_presenter.rb"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login_test_user(user)
    post sessions_path, params: { email: user.email, password: "welcome" }
  end

  def logout_test_user(user)
    delete session_path(user.id)
  end
end
