class AbilityScore < ApplicationRecord
  extend ApplicationHelper::SeedMethods

  has_many :ability_score_characters
end
