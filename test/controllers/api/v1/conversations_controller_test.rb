require 'test_helper'

class Api::V1::ConversationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:oppung)
    @conversation = conversations(:oppung_chat)
  end

  test 'should not get user conversations if user not validated' do
    get api_v1_conversations_url, params: { user_id: @user.id }
    assert_response :forbidden
  end

  test 'should get user conversations if user validated' do
    get api_v1_conversations_url, params: { user_id: @user.id }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal 3, json_response.length
  end

  test 'should not show user conversation if user not validated' do
    get api_v1_conversation_url(@conversation), params: { user_id: @user.id }
    assert_response :forbidden
  end

  test 'should show user conversation if user validated' do
    get api_v1_conversation_url(@conversation), params: { user_id: @user.id }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response.length
  end

  test 'should add message to conversation' do
    post add_message_api_v1_conversation_url(@conversation), params: { message: { user_id: @user.id, content: 'Test Message'} }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal @user.id, json_response['user_id']
  end

  test 'should not add message to conversation if message content is blank' do
    post add_message_api_v1_conversation_url(@conversation), params: { message: { user_id: @user.id } }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    assert_response :unprocessable_entity
  end

  test 'should not add message to conversation if the user not validated' do
    post add_message_api_v1_conversation_url(@conversation), params: { message: { user_id: @user.id, content: 'Test Message'} }, as: :json
    assert_response :forbidden
  end

end
