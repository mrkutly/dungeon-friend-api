class SessionsController < ApplicationController

  before_action :authorized, only: :index

  def create
    current_user

    if @user && @user.authenticate(session_params[:password])
      token = encode_token(user_id: @user.id)
      render json: { user: { id: @user.id }, token: token }, status: :accepted
    else
      render json: { errors: "Invalid username or password" }, status: :unauthorized
    end
  end

  def index
    render json: { user: {id: @user.id} }, status: :accepted
  end

  private

  def session_params
    params.require(:user).permit(:name, :password)
  end

  def current_user
    @user ||= User.find_by(name: session_params[:name])
  end
end
