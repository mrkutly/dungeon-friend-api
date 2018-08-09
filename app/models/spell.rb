class Spell < ApplicationRecord
  extend ApplicationHelper::SeedMethods
  include ApplicationHelper::InstanceMethods

  has_many :character_spells

  def spell_data
    return self.data
  end
end
