class ContactBlueprint < Blueprinter::Base

  identifier :id

  view :normal do
    association :friend, blueprint: UserBlueprint
  end

end
