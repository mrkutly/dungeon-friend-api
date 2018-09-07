class SessionsController < ApplicationController

  def create
    current_user

    if @user && @user.authenticate(session_params[:password])
      render json: { id: @user.id }
    else
      render json: { errors: "Invalid username or password" }, status: :unauthorized
    end
  end

  private

  def session_params
    params.require(:user).permit(:name, :password)
  end

  def current_user
    @user ||= User.find_by(name: session_params[:name])
     # TestUser.find_or_create_by(session_params[:name])
  end

end
