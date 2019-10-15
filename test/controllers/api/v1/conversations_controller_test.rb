require 'test_helper'

class Api::V1::ConversationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @sender = users(:one)
    @receiver = users(:two)
  end

  test 'should create conversation with sender as user_one' do
    assert_difference('Conversation.count') do
      post api_v1_conversations_url, params: { conversation: { user_one_id: @sender.id, user_two_id: @receiver.id } }, headers: { Authorization: JsonWebToken.encode(user_id: @sender.id) }, as: :json 
    end
    assert_response :created
  end

  test 'should not create conversation if user_one not valid' do
    assert_no_difference('Conversation.count') do
      post api_v1_conversations_url, params: { conversation: { user_one_id: @receiver.id, user_two_id: @receiver.id } }, headers: { Authorization: JsonWebToken.encode(user_id: @sender.id) }, as: :json 
    end
    assert_response :forbidden
  end

  test 'should not create conversation if conversation not valid' do
    assert_no_difference('Conversation.count') do
      post api_v1_conversations_url, params: { conversation: { user_one_id: @sender.id } }, headers: { Authorization: JsonWebToken.encode(user_id: @sender.id) }, as: :json 
    end
    assert_response :unprocessable_entity
  end

end
