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


  has_one_attached :picture

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
    message = MessageBlueprint.render_as_json(self)
    ActionCable.server.broadcast "conversation_#{ self.conversation_id }_notification_channel", message
    # receiver = self.conversation.user_one_id == self.user_id ? self.conversation.user_two_id : self.conversation.user_one_id
    # response = self.attributes.merge(user: self.user&.name)
    # ActionCable.server.broadcast "user_#{ receiver }_notification_channel", response.as_json.to_s
  end


end
