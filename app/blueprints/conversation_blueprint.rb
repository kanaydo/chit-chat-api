class ConversationBlueprint < Blueprinter::Base

  identifier :id

  view :normal do
    association :user_one, blueprint: UserBlueprint
    association :user_two, blueprint: UserBlueprint
  end

end
