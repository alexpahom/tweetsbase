require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @params = {
      username: 'ninja-lady',
      first_name: 'Selena',
      last_name: 'Gilderoy',
      email: 'ninja@example.com',
      phone: '111-333-1121',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  test 'Login is reachable' do
    get login_path
    assert_response :success
  end

  test 'User can log in' do
    login :one
    assert logged_in?
  end

  test 'User can log out' do
    login :one
    logout
    assert_not logged_in?
  end

  test 'User cannot login with invalid creds' do
    post login_path, params: { session: { username: '111', password: 'password' } }
    assert_not logged_in?
  end

  test 'User is being logged in automatically after signup' do
    post users_path, params: { user: @params }
    assert logged_in?
  end

  test 'User can sign up not being logged in' do
    get signup_path
    assert_not logged_in?
  end

  test 'If user is logged in /login is unreachable' do
    login :one
    get login_path
    verify_redirects
  end

  test 'If user is not logged in, he is taken to login' do
    user = User.first
    message = user.messages.first.id
    [
      messages_path,
      user_messages_path(user),
      new_user_message_path(user),
      edit_user_message_path(user, message),
      user_message_path(user, message),
      users_path,
      edit_user_path(user),
      user_path(user)
    ].each do |path|
      get path
      verify_redirects(path)
      assert_equal '/login', request.fullpath
    end
  end

  # test 'Forget is reachable'
  # test 'User A cannot edit B's profile
  # test 'User A cannot edit B's message
  # test 'User A cannot delete B's message
  # test 'User A cannot create a message as B'
end
