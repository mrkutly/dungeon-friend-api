class CharactersController < ApplicationController

  def index
    @characters = Character.where(test_user_id: params[:test_user_id])
    render json: @characters
  end
end
