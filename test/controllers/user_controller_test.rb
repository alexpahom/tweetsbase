require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  def setup
    @params = {
      'username' => 'ninja-lady',
      'first_name' => 'Selena',
      'last_name' => 'Gilderoy',
      'email' => 'ninja@example.com',
      'phone' => '111-333-1121'
    }
    @invalid_params = {
      'username' => 'ninja-lady',
      'first_name' => 'Selena',
      'last_name' => '',
      'email' => 'ninja1com',
      'phone' => '111-333-1121'
    }
  end

  def verify_redirects
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'Home is reachable' do
    get root_path
    assert_response :success
  end

  test 'Users are reachable' do
    get users_path
    assert_response :success
  end

  test 'Creation page is reachable' do
    get users_new_path
    assert_response :success
  end

  test 'Show is reachable' do
    get user_path(User.all.first)
    assert_response :success
  end

  test  'Create valid user' do
    post '/users', params: { user: @params }
    assert assigns(:user).valid?
    verify_redirects
  end

  test  'Create invalid user' do
    post '/users', params: { user: @invalid_params }
    assert_not assigns(:user).valid?
  end

  test 'Update is reachable' do
    get edit_user_path(User.all.first)
    assert_response :success
  end

  test 'Update valid user' do
    user = User.all.first
    patch user_path(user), params: { user: @params }
    verify_redirects
  end

  test 'Delete user' do
    user = User.first
    delete user_path(user)
    verify_redirects
  end
end
