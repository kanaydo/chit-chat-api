class User < ApplicationRecord

  ## ATTRIBUTES:
  # - name:string 
  # - username:string 
  # - email:string 
  # - password_digest:string


  ## RELATIONSHIP:
  has_many :conversations, class_name: 'Conversation', foreign_key: 'user_one_id', dependent: :destroy
  has_many :messages, dependent: :destroy


  ## MODEL HELPERS
  has_secure_password


  # MODEL VALIDATIONS
  validates :name,
    presence: { message: "must filled!" }

  validates :username,
    presence: { message: "must filled!" },
    uniqueness: { message: "this username already taken!" },
    format: { without: /\s/ }

  validates :email,
    presence: { message: "must be filled!" },
    uniqueness: { message: "this username already taken!" },
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "email format must be valid!" }

  validates :password_digest,
    presence: { message: "must filled!" }


  # MODEL FUNCTION

  # fetch all user conversations
  def conversation_list
    Conversation.user_conversation(self.id)
  end

end
