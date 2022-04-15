class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def show
    render json: UserSerializer.render_as_hash(current_user), status: :ok
  end

  def create
    new_user = User.create_with(create_params).find_or_create_by!(username: create_params[:username])
    new_device = Device.create!(user: new_user)

    render json: { token: new_device.auth_token }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :bad_request
  end

  def chat_token
    render json: { token: GetStream.instance.create_user_token(current_user.chat_id) }, status: :ok
  end

  def create_params
    params.permit(User.fillable)
  end
end
