class RacesController < ApplicationController

  def index
    @races = Race.all
    render json: @races
  end

  def show
    @race = Race.find_by(id: params[:id])
    render json: @race.show_format
  end
end
