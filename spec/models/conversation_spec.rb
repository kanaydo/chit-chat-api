require 'rails_helper'

RSpec.describe Conversation, type: :model do
  fixtures :users
  fixtures :conversations
  before do
    @user_one = users(:one)
    @user_two = users(:two)
    @user_three = users(:three)
    @user_four = users(:four)
    @user_five = users(:five)
    @conversation_one = conversations(:one)
  end
  context 'validation test' do
    it 'should be valid conversation' do
      conversation = Conversation.new(
        user_one_id: @user_one.id,
        user_two_id: @user_five.id
      )
      expect(conversation.valid?).to eq(true)
    end
    context 'user_one_id validation' do
      it 'should be present' do
        conversation = Conversation.new(
          user_two_id: @user_four.id
        )
        expect(conversation.valid?).to eq(false)
      end
    end
    context 'user_two_id validation' do
      it 'should be present' do
        conversation = Conversation.new(
          user_one_id: @user_one.id
        )
        expect(conversation.valid?).to eq(false)
      end
    end
  end

  context 'relation test' do
    it 'should belongs to user' do
      user_one = @conversation_one.user_one
      expect(user_one.username).to eq('user_one')
      user_two = @conversation_one.user_two
      expect(user_two.username).to eq('user_two')
    end
  end
end
