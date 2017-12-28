require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @params = { 'content' => 'Let me put you on hold' }
  end

  test 'Home is reachable' do
    get root_path
    assert_response :success
  end

  test 'Recent messages are reachable' do
    get messages_path
    assert_response :success
  end

  test 'Message creation page is reachable' do
    get new_user_message_path(User.find(20))
    assert_response :success
  end

  test 'User is able to create a message' do
    post user_messages_url(User.find(10)), params: { message: @params }
    assert assigns(:message).valid?
    verify_redirects
  end

  test 'User is able to update a message' do
    user = User.find(20)
    message = user.messages.first
    old_post = message.content
    patch user_message_url(user, message), params: { message: @params }
    verify_redirects
    assert_not_equal old_post, user.messages.first.content
  end

end
