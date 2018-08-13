class SessionsController < ApplicationController

  def create
    current_user

    render json: @user
  end

  private

  def session_params
    params.require(:user).permit(:name)
  end

  def current_user
    @user ||= TestUser.find_or_create_by(session_params)
  end
  
end
