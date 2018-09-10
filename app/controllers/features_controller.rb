class FeaturesController < ApplicationController

  def index
    @features = Feature.all.uniq { |el| el.name }
    render json: @features
  end
end
