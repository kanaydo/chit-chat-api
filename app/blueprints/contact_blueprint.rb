class ContactBlueprint < Blueprinter::Base

  identifier :id

  view(:normal) { association :friend, blueprint: UserBlueprint }

end
