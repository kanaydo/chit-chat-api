require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @new_user = users(:two)
  end

  test 'should create user valid user' do
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { name: 'test user 2', username: 'test2', email: 'test2@email.com', password: '123' } }, as: :json
    end
    assert_response :created
  end

  test 'should not create user with taken username' do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { name: 'test user 2', username: @user.username, email: @user.email, password: '123' } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test 'should show user' do
    get api_v1_user_url(@user), as: :json
    assert_response :ok
    json_response = JSON.parse(@response.body)
    assert_equal @user.email, json_response['email']
  end

  test 'should update user with' do
    patch api_v1_user_url(@user), params: { user: { name: 'New Test', username: 'new_test', email: 'newtest@email.com', password: '123' } }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    assert_response :ok
  end

  test 'should not update user if invalid' do
    patch api_v1_user_url(@user), params: { user: { name: 'New Test', username: 'new test', email: 'newtestemail.com', password: '123' } }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    assert_response :not_modified
  end

  test 'should not update user if conflict' do
    patch api_v1_user_url(@user), params: { user: { name: 'New Test', username: @new_user.username, email: 'test@email.com', password: '123' } }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    assert_response :not_modified
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user), headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    end
    assert_response :no_content
  end

  test 'should not destroy user' do
    assert_no_difference('User.count', -1) do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :forbidden
  end

  test 'should add user to contact' do
    assert_difference('Contact.count') do
      post add_to_contact_api_v1_user_url(@new_user), params: { contact: { user_id: @user.id } }, headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    end
    assert_response :created
  end

  test 'should not add user to contact if not validated' do
    assert_no_difference('Contact.count') do
      post add_to_contact_api_v1_user_url(@new_user), params: { contact: { user_id: @user.id } }, as: :json
    end
    assert_response :forbidden
  end

end
