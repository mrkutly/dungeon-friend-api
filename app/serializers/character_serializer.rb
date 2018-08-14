class CharacterSerializer < ActiveModel::Serializer
  attributes :name, :level, :race, :job, :features, :spells, :ability_scores, :conditions, :equipment, :languages, :proficiencies, :skills
end
