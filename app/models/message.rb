class Message < ApplicationRecord

  ## ATTRIBUTES:
  # - conversation_id:integer 
  # - user_id:integer
  # - content:text 


  ## RELATIONSHIP:
  belongs_to :user, dependent: :destroy
  belongs_to :conversation, dependent: :destroy


  ## MODEL VALIDATION
  validates :conversation_id,
    presence: { message: "must filled!" }
  validates :user_id,
    presence: { message: "must filled!" }
  validates :content,
    presence: { message: "must filled!" }


end
