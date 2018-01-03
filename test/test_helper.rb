require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def verify_redirects
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def login(name)
    post login_path, params: { session: { username: users(name).username, password: 'password' } }
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
  # Add more helper methods to be used by all tests here...
end
