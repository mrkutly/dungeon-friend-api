class CharactersController < ApplicationController

  def index
    @characters = Character.where(test_user_id: params[:test_user_id])
    render json: @characters
  end

  def create
    @character = Character.new_from_params(character_params, params[:character])

    if @character.save
      render json: @character
    else
      render json: { errors: @character.errors.full_messages }, status: 400
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :race_id, :job_id, :level, :test_user_id, :strength, :charisma, :dexterity, :wisdom, :intelligence, :constitution)
  end
end
