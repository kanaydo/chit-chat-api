require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users
  fixtures :conversations
  fixtures :contacts

  before do
    @one = users(:one)
    @two = users(:two)
    @three = users(:three)
    @four = users(:four)
  end

  context 'validation test' do

    context 'name validation' do
      it 'should be present' do
        user = User.new(
          username: 'test',
          email: 'test@email.com',
          password: 'test_password'
        )
        expect(user.valid?).to eq(false)
      end
    end

    context 'username validation' do
      it 'should be present' do
        user = User.new(
          name: 'Test User',
          email: 'test@email.com',
          password: 'test_password'
        )
        expect(user.valid?).to eq(false)
      end
      it 'should be unique' do
        user = User.new(
          name: 'Test User',
          username: @one.username,
          email: 'test@email.com',
          password: 'test_password'
        )
        expect(user.valid?).to eq(false)
      end
      it 'should not contain space' do
        user = User.new(
          name: 'Test User',
          username: 'test user',
          email: 'test@email.com',
          password: 'test_password'
        )
        expect(user.valid?).to eq(false)
      end
    end

    context 'email validation' do
      it 'should be present' do
        user = User.new(
          name: 'Test User',
          username: 'test',
          password: 'test_password'
        )
        expect(user.valid?).to eq(false)
      end
      it 'should be unique' do
        user = User.new(
          name: 'Test User',
          username: 'test',
          email: @one.email,
          password: 'test_password'
        )
        expect(user.valid?).to eq(false)
      end
      it 'should use email format' do
        user = User.new(
          name: 'Test User',
          username: 'test',
          email: 'testemail.com',
          password: 'test_password'
        )
        expect(user.valid?).to eq(false)
      end
    end

    context 'password validation' do
      it 'should be present' do
        user = User.new(
          name: 'Test User',
          email: 'test@email.com',
          username: 'test'
        )
        expect(user.valid?).to eq(false)
      end
    end

    it 'should a valid user' do
        user = User.new(
          name: 'Test User',
          email: 'test@email.com',
          username: 'test',
          password: 'test_password'
        )
        expect(user.valid?).to eq(true)
    end
  end

  context 'relation test' do
    it 'should has many conversations as owner' do
      expect(@one.own_conversations.size).to eq(2)
      expect(@two.own_conversations.size).to eq(1)
      expect(@three.own_conversations.size).to eq(0)
    end
    it 'should has many conversations as guest' do
      expect(@one.guest_conversations.size).to eq(0)
      expect(@two.guest_conversations.size).to eq(1)
      expect(@three.guest_conversations.size).to eq(2)
    end
    it 'should has many contacts' do
      expect(@one.contacts.size).to eq(2)
      expect(@two.contacts.size).to eq(1)
      expect(@three.contacts.size).to eq(0)
    end
  end

  context 'model function' do
    context 'function conversation_list' do
      it 'should return user conversation list' do
        expect(@one.conversation_list.size).to eq(2)
        expect(@two.conversation_list.size).to eq(2)
        expect(@three.conversation_list.size).to eq(2)
        expect(@four.conversation_list.size).to eq(0)
      end
    end
    context 'function contact_list' do
      it 'should return contact list' do
        expect(@one.contact_list.size).to eq(2)
        expect(@two.contact_list.size).to eq(1)
        expect(@three.contact_list.size).to eq(0)
        expect(@four.contact_list.size).to eq(0)
      end
    end
  end
end
