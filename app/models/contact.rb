class Contact < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User'

  def self.check_contact(user_id, friend_id)
    self.find_by(user_id: user_id, friend_id: friend_id).present?
  end

  def contact_list

  end

end
