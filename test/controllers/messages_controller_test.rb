require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @params = { 'content' => 'Let me put you on hold' }
    @u_one = users(:one)
    @u_two = users(:two)
    @m_one = @u_one.messages.first
    @m_two = @u_two.messages.first
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
    get new_user_message_path(@u_two)
    assert_response :success
  end

  # messages#create
  test 'User is able to create a message' do
    login :one
    post user_messages_url(@u_one), params: { message: @params }
    verify_redirects
  end

  # message#update
  test 'User is able to update a message' do
    login :two
    old_post = @m_two.content
    patch user_message_url(@u_two, @m_two), params: { message: @params }
    verify_redirects
    assert_not_equal old_post, @u_two.messages.first.content
  end

  # messages#edit
  test 'edit message is reachable' do
    login :one
    get edit_user_message_path(@u_one, @m_one)
    assert_response :success
  end

  # messages#show
  test 'Show message is reachable' do
    login :one
    get user_message_path(@u_one, @m_one)
    assert_response :success
  end

  # messages#index
  test 'Index page is reachable' do
    login :one
    get user_messages_path(@u_one)
    assert_response :success
  end

  # messages#destroy
  test 'User can delete a message' do
    login :two
    # user = User.find(20) @u_two
    # message = user.messages.first @m_two
    assert_difference 'Message.count', -1, 'Message was not deleted' do
      delete user_message_path(@u_two, @m_two)
    end
    assert @u_two.present?
    verify_redirects
  end

  test 'User A cannot edit B\'s message' do
    login :one
    second_message = users(:two).messages.first
    patch user_message_url(users(:two), second_message), params: { message: @params }
    assert_equal second_message, users(:two).messages.first
  end

  test 'User A cannot delete B\'s message' do
    login :one
    second = users(:two)
    message = second.messages.first
    assert_difference 'Message.count', 0 do
      delete user_message_path(second, message)
    end
  end

  test 'User A cannot create a message as B' do
    login :one
    second = users(:two)
    post user_messages_url(second), params: { message: @params }
    assert_not second.valid?
  end
end
