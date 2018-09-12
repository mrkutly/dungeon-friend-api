class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      token = encode_token({user_id: @user.id})
      render json: { user: { id: @user.id }, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
