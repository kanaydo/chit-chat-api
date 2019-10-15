require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  setup do
    @conversation = conversations(:one)
    @user = users(:one)
  end

  test 'new message should be valid' do
    message = Message.new(conversation_id: @conversation.id, user_id: @user.id, content: "hai there")
    assert message.valid?
  end

  test 'new message should be invalid' do
    message = Message.new(content: "hai there")
    assert_not message.valid?
  end
  
end
