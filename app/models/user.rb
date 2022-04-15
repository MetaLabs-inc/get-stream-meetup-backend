class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :password, presence: true, on: %i[create update], if: :password_digest_changed?

  before_create :setup_chat

  class << self
    def fillable
      [:username, :password]
    end
  end

  private

  def setup_chat
    new_chat_id = GetStream.instance.create_chat_id(self)
    self.chat_id = new_chat_id
  rescue StandardError => e
    Rails.logger.error("Failure during setup_chat for user #{id}: #{e}")
  end
end
