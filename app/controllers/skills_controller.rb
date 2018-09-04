class SkillsController < ApplicationController

  def index
    @skills = Skill.all.uniq { |e| e.name }
    render json: @skills
  end
end
