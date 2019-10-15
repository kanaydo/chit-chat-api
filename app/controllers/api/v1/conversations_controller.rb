class Api::V1::ConversationsController < ApplicationController

  before_action :set_sender, only: [:index, :create]
  before_action :check_sender, only: [:index, :create]

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

  private
  def conversation_params
    params.require(:conversation).permit(
      :user_one_id,
      :user_two_id
    )
  end

  # set current user to specific action
  def set_sender
    @sender = User.find conversation_params[:user_one_id]
  end

  # validate conversation owner
  def check_sender
    head :forbidden unless @sender.id == current_user&.id
  end

end
