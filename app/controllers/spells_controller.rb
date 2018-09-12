class SpellsController < ApplicationController

  def index
    @spells = Spell.all
    render json: { spells: @spells }
  end
end
