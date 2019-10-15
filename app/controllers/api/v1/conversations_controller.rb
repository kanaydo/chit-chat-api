class Api::V1::ConversationsController < ApplicationController

  before_action :set_owner, only: [:index, :create]
  before_action :set_sender, only: [:add_message]
  before_action :set_conversation, only: [:add_message]
  before_action :check_sender, only: [:index, :create, :add_message]

  def index
  
  end

  def create
    conversation = @sender.conversations.new conversation_params
    if conversation.save
      render json: conversation, status: :created
    else
      render json: conversation.errors, status: :unprocessable_entity
    end
  end

  def add_message
    message = @conversation.messages.new message_params
    if message.save
      render json: message, status: :created
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end

  private
  def conversation_params
    params.require(:conversation).permit(
      :user_one_id,
      :user_two_id
    )
  end

  def message_params
    params.require(:message).permit(
      :user_id,
      :content
    )
  end

  def set_conversation
    @conversation = Conversation.find params[:id]
  end

  # set current user to specific action
  def set_owner
    @sender = User.find conversation_params[:user_one_id]
  end

  # set message sender
  def set_sender
    @sender = User.find message_params[:user_id]
  end

  # validate conversation owner
  def check_sender
    head :forbidden unless @sender.id == current_user&.id
  end

end
