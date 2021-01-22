class User < ApplicationRecord

  ## ATTRIBUTES:
  # - name:string
  # - username:string
  # - email:string
  # - password_digest:string


  ## RELATIONSHIP:
  has_many :own_conversations, class_name: 'Conversation', foreign_key: 'user_one_id', dependent: :destroy
  has_many :guest_conversations, class_name: 'Conversation', foreign_key: 'user_two_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :contacts, class_name: 'Contact', foreign_key: 'user_id', dependent: :destroy


  ## MODEL HELPERS
  has_secure_password

  has_one_attached :image


  # MODEL VALIDATIONS
  validates :name,
    presence: { message: "Name must filled!" }

  validates :username,
    presence: { message: "Username must filled!" },
    uniqueness: { message: "This username already taken!" },
    format: { without: /\s/ }

  validates :email,
    presence: { message: "Email must be filled!" },
    uniqueness: { message: "This email already used!" },
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email format must be valid!" }

  validates :password_digest,
    presence: { message: "Password must filled!" }


  # MODEL FUNCTION

  # fetch all user conversations
  def conversation_list
    Conversation.user_conversation(self.id)
  end

  def contact_list
    Contact.where('user_id = ?', self.id)
  end

  def self.search term
    where('lower(name) LIKE lower(?) or lower(username) LIKE lower(?)', "%#{ term }%", "%#{ term }%").first
  end

  def self.find_by_credential(credential)
    where('username = ? or email = ?', credential, credential).first
  end

end
