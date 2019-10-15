class Conversation < ApplicationRecord
  
  ## ATTRIBUTES:
  # user_one_id:references
  # user_two_id:references


  ## RELATIONSHIP:
  belongs_to :user_one, class_name: 'User', dependent: :destroy
  belongs_to :user_two, class_name: 'User', dependent: :destroy
  has_many :messages, dependent: :destroy

  # MODEL VALIDATIONS
  validates :user_one_id,
    presence: { message: "must filled!" }
  validates :user_two_id,
    presence: { message: "must filled!" }

end
