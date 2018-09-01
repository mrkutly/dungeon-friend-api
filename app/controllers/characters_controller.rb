class CharactersController < ApplicationController

  def index
    @characters = Character.where(test_user_id: params[:test_user_id])
    render json: @characters
  end

  def create
    @character = Character.new(character_params)
    languages = params[:character][:languages].map { |lang| Language.find_by(name: lang) }

    skills, profs = params[:character][:proficiencies].partition do |el|
      el[:name].include?("Skill:")
    end

    skills = skills.map { |skill| Skill.find_by(name: skill[:name][7..-1]) }

    proficiencies = profs.map { |prof| Proficiency.find_by(url: prof[:url]) }

    equipment = []

    params[:character][:equipment].each do |e|
      item = Equipment.find_by(url: e[:item][:url])
      e[:quantity].times do
        equipment << item
      end
    end

    @character.languages = languages
    @character.proficiencies = proficiencies
    @character.equipment = equipment
    @character.skills = skills

    if @character.save
      render json: @character
    else
      render json: { errors: @character.errors.full_messages }, status: 400
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :race_id, :job_id, :level, :test_user_id)
  end
end
