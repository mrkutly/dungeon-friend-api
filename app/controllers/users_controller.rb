class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: @user }, status: :created
    else
      render json: { error: "Invalid user" }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

end
