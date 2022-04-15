module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :require_login
  end

  def require_login
    render json: { error: 'Unauthorized' }, status: :unauthorized if current_user.nil?
  end

  def current_user
    @current_user ||= current_device&.user
  end

  def current_device
    @current_device ||= Device.includes(:user).where(auth_token: request.headers['Authorization']).first
  end
end
