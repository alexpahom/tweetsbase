require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @params = { 'content' => 'Let me put you on hold' }
  end

  # messages#recent (ROOT)
  test 'Home is reachable' do
    get root_path
    assert_response :success
  end

  # messages#recent (GET messages)
  test 'Recent messages are reachable' do
    get messages_path
    assert_response :success
  end

  # messages#new
  test 'Message creation page is reachable' do
    get new_user_message_path(User.find(20))
    assert_response :success
  end

  # messages#create
  test 'User is able to create a message' do
    post user_messages_url(User.find(10)), params: { message: @params }
    assert assigns(:message).valid?
    verify_redirects
  end

  # message#update
  test 'User is able to update a message' do
    user = User.find(20)
    message = user.messages.first
    old_post = message.content
    patch user_message_url(user, message), params: { message: @params }
    verify_redirects
    assert_not_equal old_post, user.messages.first.content
  end

  # messages#edit
  test 'edit message is reachable' do
    user = User.first
    get edit_user_message_path(user, user.messages.first)
    assert_response :success
  end

  # messages#show
  test 'Show message is reachable' do
    user = User.first
    get user_message_path(user, user.messages.first)
    assert_response :success
  end

  # messages#index
  test 'Index page is reachable' do
    get user_messages_path(User.first)
    assert_response :success
  end

  # messages#destroy
  test 'User can delete a message' do
    user = User.find(20)
    message = user.messages.first
    delete user_message_path(user, message)
    assert user.present?
    assert_not_equal message, user.messages.first, 'Message was not deleted'
    verify_redirects
  end

  test 'Plaseholder for no messages on users page' do
    user = User.first
    user.messages.destroy_all
    get user_messages_path(user)
    assert_select 'em', 'No messages yet. Go ahead and post!'
  end

  test 'Placeholder for no messages on recent page' do
    Message.destroy_all
    get root_path
    assert_select 'em', 'No messages yet. Go ahead and post!'
  end
end
