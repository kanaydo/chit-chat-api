class Conversation < ApplicationRecord
  
  ## ATTRIBUTES:
  # user_one_id:references
  # user_two_id:references


  ## RELATIONSHIP:
  belongs_to :user_one, class_name: 'User', dependent: :destroy
  belongs_to :user_two, class_name: 'User', dependent: :destroy
  has_many :messages, dependent: :destroy, foreign_key: 'conversation_id'

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

end
