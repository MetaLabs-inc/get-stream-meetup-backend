require 'stream-chat'

class GetStream
  include Singleton

  def client
    @client ||= StreamChat::Client.new(ENV['STREAM_KEY'], ENV['STREAM_SECRET'])
  end

  def create_chat_id(user)
    chat_id = calculate_id(user)
    client.update_user({ id: chat_id, name: user.username })

    chat_id
  end

  def create_user_token(user_chat_id)
    client.create_token(user_chat_id)
  end

  private

  def calculate_id(user)
    "#{user.username}_stream"
  end
end
