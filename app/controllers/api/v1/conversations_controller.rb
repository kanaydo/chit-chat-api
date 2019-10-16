class Api::V1::ConversationsController < ApplicationController

  before_action :set_conversation_member, only: [:index, :show]
  before_action :set_message_sender_as_conversation_member, only: [:add_message]
  before_action :set_conversation, only: [:show, :add_message]
  before_action :check_conversation_member, only: [:index, :show, :add_message]


  # get all user conversations
  def index
    conversations = @member.conversation_list
    render json: conversations, status: :ok
  end

  # show conversation conversation messages
  def show
    messages = @conversation.messages
    render json: messages, status: :ok
  end

  # add message to current conversation
  def add_message
    message = @conversation.messages.new message_params
    if message.save
      render json: message, status: :created
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end

  private

  # handle the conversation message params
  def message_params
    params.require(:message).permit(
      :user_id,
      :content
    )
  end

  # set conversation member by :user_id
  def set_conversation_member
    @member = User.find params[:user_id]
  end

  # set the selected conversation by :id
  def set_conversation
    @conversation = Conversation.find params[:id]
  end

  # set user as member to check so only the authorized user cant add message to current conversation
  def set_message_sender_as_conversation_member
    @member = User.find message_params[:user_id]
  end

  # validate conversation member, kick if validation return false
  def check_conversation_member
    head :forbidden unless @member.id == current_user&.id
  end

end
