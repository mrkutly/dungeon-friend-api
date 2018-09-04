class ProficienciesController < ApplicationController

  def index
    @proficiencies = Proficiency.all.uniq { |e| e.name }
    render json: @proficiencies
  end
end
