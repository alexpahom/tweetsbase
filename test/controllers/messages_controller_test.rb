require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @params = { 'content' => 'Let me put you on hold' }
  end

  # messages#recent (GET messages)
  test 'Recent messages are reachable' do
    login :one
    get messages_path
    assert_response :success
  end

  # messages#new
  test 'Message creation page is reachable' do
    login :two
    get new_user_message_path(User.find(20))
    assert_response :success
  end

  # messages#create
  test 'User is able to create a message' do
    login :one
    post user_messages_url(User.find(10)), params: { message: @params }
    verify_redirects
  end

  # message#update
  test 'User is able to update a message' do
    login :two
    user = User.find(20)
    message = user.messages.first
    old_post = message.content
    patch user_message_url(user, message), params: { message: @params }
    verify_redirects
    assert_not_equal old_post, user.messages.first.content
  end

  # messages#edit
  test 'edit message is reachable' do
    login :one
    user = User.first
    get edit_user_message_path(user, user.messages.first)
    assert_response :success
  end

  # messages#show
  test 'Show message is reachable' do
    login :one
    user = User.first
    get user_message_path(user, user.messages.first)
    assert_response :success
  end

  # messages#index
  test 'Index page is reachable' do
    login :one
    get user_messages_path(User.first)
    assert_response :success
  end

  # messages#destroy
  test 'User can delete a message' do
    login :two
    user = User.find(20)
    message = user.messages.first
    assert_difference 'Message.count', -1, 'Message was not deleted' do
      delete user_message_path(user, message)
    end
    assert user.present?
    verify_redirects
  end
end
