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
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/system/def.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


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
    Contact.where('user_id = ? or friend_id = ?', self.id, self.id)
  end

  def self.search term
    where('lower(name) LIKE lower(?) or lower(username) LIKE lower(?)', "%#{ term }%", "%#{ term }%")
  end

end
