require 'test_helper'

class ConversationTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
  end

  test 'user should have conversations' do
    conversations = @user.conversations
    assert_not_nil conversations
    assert_equal [], conversations
  end

end
