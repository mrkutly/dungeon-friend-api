class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :level, :race, :job,
    :features, :spells, :ability_scores,
    :conditions, :equipment, :languages,
    :proficiencies, :skills, :max_hp, :current_hp
end
