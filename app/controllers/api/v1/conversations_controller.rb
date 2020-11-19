class Api::V1::ConversationsController < ApplicationController

  before_action :set_conversation_member, only: [:index, :create]
  before_action :set_message_sender_as_conversation_member, only: [:add_message]
  before_action :set_conversation, only: [:show, :add_message, :last_message, :messages]


  def index
    conversations = ConversationBlueprint.render(
      @user.conversation_list,
      view: :normal,
      root: :conversations
    )
    render json: conversations, status: :ok
  end

  def create
    conversation = @member.own_conversations.new conversation_params
    if conversation.save
      render json: conversation, status: :created
    else
      render json: conversation.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @conversation, status: :ok
  end

  def messages
    messages = @conversation.messages.order('created_at desc')
    render json: messages, status: :ok
  end

  def add_message
    message = @conversation.messages.new message_params
    if message.save
      render json: message, status: :created
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end

  def last_message
    message = @conversation.messages.last
    render json: message, status: :ok
  end


  private
  def conversation_params
    params.require(:conversation).permit(
      :user_two_id
    )
  end

  def message_params
    params.require(:message).permit(
      :user_id,
      :content
    )
  end

  def set_conversation_member
    @user = User.find params[:user_id] rescue nil
    if @user.nil?
      head :not_found
    end
  end

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
