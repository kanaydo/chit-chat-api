class Api::V1::ConversationsController < ApplicationController

  before_action :set_conversation_member, only: [:index, :show]
  before_action :set_conversation, only: [:show]
  before_action :check_conversation_member, only: [:index, :show]


  # get all user conversations
  def index
    conversations = @member.conversation_list
    render json: conversations, status: :ok
  end


  def show
    messages = @conversation.messages
    render json: messages, status: :ok
  end

  private

  # set conversation member by :user_id
  def set_conversation_member
    @member = User.find params[:user_id]
  end

  # set the selected conversation by :id
  def set_conversation
    @conversation = Conversation.find params[:id]
  end

  # validate conversation member, kick if validation return false
  def check_conversation_member
    head :forbidden unless @member.id == current_user&.id
  end

end
