class EquipmentController < ApplicationController

  def index
    @equipment = Equipment.all.uniq { |e| e.name }
    render json: @equipment
  end
end
