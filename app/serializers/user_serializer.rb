class UserSerializer < ApplicationSerializer
  identifier :id

  fields :username, :chat_id
end
