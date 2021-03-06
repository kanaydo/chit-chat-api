class Conversation < ApplicationRecord

  ## ATTRIBUTES:
  # user_one_id:references
  # user_two_id:references


  ## RELATIONSHIP:
  belongs_to :user_one, class_name: 'User'
  belongs_to :user_two, class_name: 'User'
  has_many :messages, dependent: :destroy, foreign_key: 'conversation_id'
  after_create :notify_receiver
  validates_uniqueness_of :user_one_id, scope: :user_two_id

  # MODEL VALIDATIONS
  validates :user_one_id,
    presence: { message: "must filled!" }
  validates :user_two_id,
    presence: { message: "must filled!" }


  ## MODEL FUNCTION

  # get all user conversation by user_id
  def self.user_conversation(user_id)
    # if the user is user_one or user_two for any conversations
    self.where(user_one_id: user_id).or(self.where(user_two_id: user_id))
  end

  def self.having_conversation?(user_id, friend_id)
    self.find_by('user_one_id = ? AND user_two_id = ? OR user_one_id = ? AND user_two_id = ?', user_id, friend_id, friend_id, user_id)
  end

  # send notification to user_two if he had a conversation
  def notify_receiver
    conversation = ConversationBlueprint.render_as_json(self, view: :normal)
    ActionCable.server.broadcast "user_#{ self.user_two_id }_notification_channel", conversation
  end

end
