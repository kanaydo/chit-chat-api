class MessageBlueprint < Blueprinter::Base

  identifier :id
  fields :conversation_id, :user_id, :content

end
