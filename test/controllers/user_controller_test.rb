require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
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
    @invalid_params = {
      username: 'ninja-lady',
      first_name: 'Selena',
      last_name: '',
      email: 'ninja1com',
      phone: '111-333-1121',
      password: 'password'
    }
  end

  test 'Users are reachable' do
    login :one
    get users_path
    assert_response :success
  end

  test 'Signup is reachable for not logged in user' do
    # get new_user_path
    get signup_path
    assert_response :success
  end

  test 'Show is reachable' do
    login :one
    get user_path(User.first)
    assert_response :success
  end

  test  'Create valid user' do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: @params }
    end
    verify_redirects
  end

  test  'Create invalid user' do
    assert_difference 'User.count', 0 do
      post users_path, params: { user: @invalid_params }
    end
  end

  test 'Update is reachable' do
    login :one
    get edit_user_path(User.first)
    assert_response :success
  end

  test 'Update valid user' do
    login :one
    user = User.first
    patch user_path(user), params: { user: @params }
    verify_redirects
  end

  test 'Delete user' do
    login :one
    assert_difference 'User.count', -1 do
      delete user_path(users(:one))
    end
    verify_redirects
  end
end
