class Message < ApplicationRecord

  after_create :send_message_notification

  ## ATTRIBUTES:
  # - conversation_id:integer 
  # - user_id:integer
  # - content:text 

  after_create :send_message_notification


  ## RELATIONSHIP:
  belongs_to :user
  belongs_to :conversation


  ## MODEL VALIDATION
  validates :conversation_id,
    presence: { message: "must filled!" }
  validates :user_id,
    presence: { message: "must filled!" }
  validates :content,
    presence: { message: "must filled!" }

  # handle private action inside message model
  private
  
  # send message notification after new message created
  def send_message_notification
    ActionCable.server.broadcast "conversation_#{ self.conversation_id }_notification_channel", self
  end


end
