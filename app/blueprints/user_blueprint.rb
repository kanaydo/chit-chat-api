class UserBlueprint < Blueprinter::Base

  identifier :id
  fields :name, :username, :email
  field :image do |user|
     user.image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(user.image, only_path: true) : '/system/def.jpg'
  end

end
