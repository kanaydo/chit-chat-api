require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = users(:one)
  end

  # test valid user attributes (name, username, email)
  test "user with valid attributes should be valid" do
    user = User.new(name: 'test user', username: "test2", email: 'email@email.com', password_digest: 'test_password')
    assert user.valid?
  end

  # test invalid user attributes (name, username, email)
  test "user with invalid attributes should be invalid" do
    user = User.new(username: 'test user', email: 'test email .com')
    assert_not user.valid?
  end

  # test unique user attributes (username, email)
  test 'user with duplicate username, email should be invalid' do
    user = User.new(username: 'test', email: 'test@email.com')
    assert_not user.valid?
  end


end
