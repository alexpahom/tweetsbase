require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = Message.new(
      user_id: 10,
      content: 'New message'
    )
  end

  test 'message can be created' do
    @message.valid?
  end

  test 'message should not be long' do
    @message.content = 'a' * 141
    assert_not @message.valid?
  end

  test 'message should be present' do
    @message.content = ''
    assert_not @message.valid?
  end
end
