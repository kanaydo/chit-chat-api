class Contact < ApplicationRecord
  belongs_to :user, class_name: 'User', dependent: :destroy
  belongs_to :friend, class_name: 'User', dependent: :destroy
end
